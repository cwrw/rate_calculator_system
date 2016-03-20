module RateCalculatorSystem
  class Calculator
    attr_reader :lenders, :requested_loan

    MINIMUM_AMOUNT = 1000
    MAXIMUM_AMOUNT = 15_000
    LOAN_PERIOD = 3

    def initialize(requested_loan, lenders)
      @requested_loan = Float(requested_loan)
      @lenders = sort_by_rate!(lenders)
    end

    def final_rate
      raise RateCalculatorSystem::InvalidLoanError unless loan_valid?
      raise RateCalculatorSystem::NoFundsError unless funds_available?
      rate_output
    end

    def loan_valid?
      requested_loan >= MINIMUM_AMOUNT &&
        requested_loan <= MAXIMUM_AMOUNT &&
        requested_loan % 100 == 0
    end

    def funds_available?
      requested_loan <= total_funds
    end

    private

    def sort_by_rate!(array)
      array.sort! { |a, b| a.rate <=> b.rate }
    end

    def total_funds
      lenders.inject(0) { |a, e| a + e.amount }
    end

    def rate_output
      %(
        Requested amount: £#{requested_loan.to_i}
        Rate: #{rate}%
        Monthly repayment: £#{monthly_payment}
        Total repayment: £#{total_payment}
      )
    end

    def rate
      (((total_payment / requested_loan)**(1 / LOAN_PERIOD.to_f) - 1) * 100).round(1)
    end

    def total_payment
      @_total_payment ||= (
        loan_value = requested_loan
        evaluate_total(loan_value).round(2)
      )
    end

    def evaluate_total(loan_value)
      lenders.inject(0) do |total, lender|
        return total if loan_value <= 0
        total += monthly_compounding_interest(amount(loan_value, lender.amount), lender.rate)
        loan_value -= lender.amount
        total
      end
    end

    def monthly_compounding_interest(amount, interest_rate)
      amount * (1 + interest_rate)**LOAN_PERIOD
    end

    def amount(loan_value, lender_amount)
      loan_value <= lender_amount ? loan_value : lender_amount
    end

    def monthly_payment
      (total_payment / 12).round(2)
    end
  end
end
