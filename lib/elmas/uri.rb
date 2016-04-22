module Elmas
  module Resource
    module UriMethods
      def base_path
        Utils.collection_path self.class.name
      end

      def uri(options = {})
        options.each do |option|
          send("apply_#{option}".to_sym)
        end
        if options.include?(:id)
          uri = URI("#{base_path}(guid'#{id}')")
        else
          uri = URI(base_path)
        end
        uri.query = URI.encode_www_form(@query)
        uri
      end

      def base_filter(attribute)
        values = @attributes[attribute]
        values = [values] unless values.is_a?(Array)

        filters = values.map do |value|
          if value.is_a?(Hash)
            value.map do |key, val|
              "#{query_attribute(attribute)} #{key} #{sanitize_value(val)}"
            end
          else
            "#{query_attribute(attribute)} eq #{sanitize_value(value)}"
          end
        end.flatten

        ["$filter", filters.join(" or ")]
      end

      # Sanitize an attribute in symbol format to the ExactOnline style
      def query_attribute(attribute)
        if attribute == :id
          attribute.to_s.upcase
        else
          Utils.camelize(attribute)
        end
      end

      # Convert a value to something usable in an ExactOnline request
      def sanitize_value(value)
        if value.is_a?(String)
          if value =~ /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
            "guid'#{value}'"
          else
            "'#{value}'"
          end
        else
          value
        end
      end

      def apply_filters
        return unless @filters
        @filters.each do |filter|
          @query << base_filter(filter)
        end
      end

      def apply_top
        @query << ["$top", @top] if @top
      end

      def apply_expand
        @query << ["$expand", Utils.camelize(@expand.to_s)] if @expand
      end

      def basic_identifier_uri
        "#{base_path}(guid'#{id}')"
      end

      def apply_order
        @query << ["$order_by", Utils.camelize(@order_by.to_s)] if @order_by
      end

      def apply_select
        @query << ["$select", (@select.map { |s| Utils.camelize(s) }.join(","))] if @select
      end
    end
  end
end
