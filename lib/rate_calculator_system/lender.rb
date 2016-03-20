module RateCalculatorSystem
  class Lender
    attr_reader :name, :rate, :amount
    def initialize(name:, rate:, amount:)
      @name = name
      @rate = rate
      @amount = amount
    end

    def ==(other)
      other.is_a?(Lender) &&
        other.name == name &&
        other.rate == rate &&
        other.amount == amount
    end
  end
end
