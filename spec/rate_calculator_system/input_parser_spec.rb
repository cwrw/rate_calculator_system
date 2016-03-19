require "spec_helper"

RSpec.describe RateCalculatorSystem::InputParser do
  let(:market_data_file) do
    File.join(File.dirname(__FILE__), "../support/fixtures/market_data.csv")
  end

  let(:parsed_result) do
    [
      RateCalculatorSystem::Lender.new(name: "Bob", rate: 0.075, amount: 640),
      RateCalculatorSystem::Lender.new(name: "Jane", rate: 0.069, amount: 480),
      RateCalculatorSystem::Lender.new(name: "Fred", rate: 0.071, amount: 520),
      RateCalculatorSystem::Lender.new(name: "Mary", rate: 0.104, amount: 170),
      RateCalculatorSystem::Lender.new(name: "John", rate: 0.081, amount: 320),
      RateCalculatorSystem::Lender.new(name: "Dave", rate: 0.074, amount: 140),
      RateCalculatorSystem::Lender.new(name: "Angela", rate: 0.071, amount: 60)
    ]
  end

  subject { described_class.new(market_data_file) }

  it "returns an array of lender objects from the file" do
    expect(subject.parse).to eq(parsed_result)
  end

  context "exceptions" do
    context "invalid header" do
      let(:market_data_file) do
        File.join(File.dirname(__FILE__), "../support/fixtures/invalid_header.csv")
      end

      it "raise error when rows are incorrect" do
        expect { subject.parse }.to raise_error(/Invalid Header in CSV file/)
      end
    end

    context "invalid data" do
      let(:market_data_file) do
        File.join(File.dirname(__FILE__), "../support/fixtures/invalid_data.csv")
      end

      it "raise error when data types don't adhere to numbers for rate and amount" do
        expect { subject.parse }.to raise_error(ArgumentError)
      end
    end
  end
end
