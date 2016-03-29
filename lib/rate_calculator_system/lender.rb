module RateCalculatorSystem
  class Lender
    attr_reader :name, :rate, :amount, :maximum_exposure
    def initialize(name:, rate:, amount:, maximum_exposure:)
      @name = name
      @rate = rate
      @amount = amount
      @maximum_exposure = maximum_exposure
    end

    def ==(other)
      other.is_a?(Lender) &&
        other.name == name &&
        other.rate == rate &&
        other.amount == amount &&
        other.maximum_exposure == maximum_exposure
    end
  end
end
