class RateCalculatorSystem
  class InputParser
    LENDER = "Lender".freeze
    RATE = "Rate".freeze
    AMOUNT = "Available".freeze

    attr_reader :input, :lenders

    def initialize(input)
      @input = input
      @lenders = []
    end

    def parse
      header = contents.shift
      raise RateCalculatorSystem::InvalidHeaderError unless header_valid?(header)
      extract_content
    end

    private

    def contents
      @_contents ||= CSV.read(input)
    end

    def header_valid?(header)
      header.compact == [LENDER, RATE, AMOUNT]
    end

    def extract_content
      contents.each do |row|
        lenders << create_lender(row.compact)
      end

      lenders
    end

    def create_lender(row)
      RateCalculatorSystem::Lender.new(
        name: row[0],
        rate: Float(row[1]),
        amount: Float(row[2])
      )
    end
  end
end
