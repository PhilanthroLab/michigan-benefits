module Integrated
  class ChildcareExpensesDetailsController < FormsController
    include ExpensesDetails
    extend ExpensesDetails::ClassMethods

    def self.expense_type
      :childcare
    end
  end
end