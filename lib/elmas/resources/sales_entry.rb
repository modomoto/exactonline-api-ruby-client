module Elmas
  class SalesEntry
    # A sales entry needs multiple sales entry lines
    # It should also have a journal id and a contact id who ordered it
    include Elmas::Resource

    def base_path
      "salesentry/SalesEntries"
    end

    def mandatory_attributes
      [:journal, :contact, :sales_entry_lines]
    end

    def other_attributes
      [
        :batch_number, :currency, :customer, :document, :due_date, :entry_date,
        :entry_number, :invoice_number, :order_number, :payment_condition,
        :payment_reference, :process_number, :rate, :reporting_period,
        :reporting_year, :reversal, :VAT_amount_FC, :your_ref, :description
      ]
    end
  end
end
