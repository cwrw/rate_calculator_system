class RateCalculatorSystem
  class InvalidHeaderError < StandardError
    def message
      "Invalid Header in CSV file, your" \
      "data should be structured as follows" \
      "#{RateCalculatorSystem::InputParser::LENDER}," \
      "#{RateCalculatorSystem::InputParser::RATE}," \
      "#{RateCalculatorSystem::InputParser::AMOUNT}"
    end
  end
end
