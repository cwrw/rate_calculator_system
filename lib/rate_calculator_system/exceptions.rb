module RateCalculatorSystem
  class InvalidHeaderError < StandardError
    def message
      %(
        Invalid Header in CSV file, your data should be structured as follows:
        #{RateCalculatorSystem::InputParser::LENDER},
        #{RateCalculatorSystem::InputParser::RATE},
        #{RateCalculatorSystem::InputParser::AMOUNT}
      )
    end
  end

  class InvalidLoanError < StandardError
    def message
      %(
        Invalid loan value, make sure the loan you enter is between 1000 and
        15000, and that it is an increment of 100.
      )
    end
  end

  class NoFundsError < StandardError
    def message
      %(There aren't enough funds to satisfy the loan value, please try again.)
    end
  end
end
