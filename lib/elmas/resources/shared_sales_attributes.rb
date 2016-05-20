module Elmas
  module SharedSalesAttributes
    SHARED_SALES_ATTRIBUTES = [
      :currency, :invoice_to, :invoice_to_contact_person, :invoice_date,
      :description, :document, :order_date, :ordered_by_contact_person,
      :tax_schedule, :order_number, :payment_condition, :payment_reference,
      :remarks, :your_ref
    ].freeze

    SHARED_LINE_ATTRIBUTES = [
      :discount, :quantity, :amount_FC, :description, :VAT_code, :cost_center,
      :cost_unit, :VAT_percentage, :unit_code, :tax_schedule, :net_price, :notes,
      :pricelist, :project
    ].freeze
  end
end
