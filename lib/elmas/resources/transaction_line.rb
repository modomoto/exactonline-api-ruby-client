module Elmas
  class TransactionLine
    include Elmas::Resource

    def valid_actions
      [:get]
    end

    def base_path
      "financialtransaction/TransactionLines"
    end

    def mandatory_attributes
      []
    end

    def other_attributes
      [:asset_code, :amount_FC, :amount_DC, :account, :currency, :serial_number, :your_ref]
    end
  end
end
