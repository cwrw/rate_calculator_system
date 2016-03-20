require "csv"
require "pry-byebug"
require "./lib/rate_calculator_system/lender"
require "./lib/rate_calculator_system/exceptions"
require "./lib/rate_calculator_system/input_parser"
require "./lib/rate_calculator_system/calculator"

module RateCalculatorSystem
  def self.calculate(file, amount)
    lenders = RateCalculatorSystem::InputParser.new(file).parse
    puts RateCalculatorSystem::Calculator.new(amount, lenders).final_rate
  rescue => e
    puts "Could not calculate rate due to the following: #{e.message}"
  end
end
