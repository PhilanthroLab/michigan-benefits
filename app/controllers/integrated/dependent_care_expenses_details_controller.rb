module Integrated
  class DependentCareExpensesDetailsController < FormsController
    include ExpensesDetails
    extend ExpensesDetails::ClassMethods

    def self.expense_type
      :disability_care
    end
  end
end