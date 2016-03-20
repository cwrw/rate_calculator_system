class RateCalculatorSystem
  class Calculator
    attr_reader :lenders, :loan

    MINIMUM = 1000
    MAXIMUM = 15_000

    def initialize(loan, lenders)
      @loan = loan
      @lenders = lenders
    end

    def loan_valid?
      Float(loan) &&
        loan >= MINIMUM &&
        loan <= MAXIMUM &&
        loan % 100 == 0
    end
  end
end
