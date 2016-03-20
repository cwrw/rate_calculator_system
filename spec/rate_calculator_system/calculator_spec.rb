require "spec_helper"

RSpec.describe RateCalculatorSystem::Calculator do
  let(:lenders) do
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

  let(:loan) { 1100 }

  subject { described_class.new(loan, lenders) }

  describe "loan_valid?" do
    it "returns true if loan is valid" do
      expect(subject.loan_valid?).to be_truthy
    end

    context "less than minimum set value" do
      let(:loan) { 900 }
      it "raises an error" do
        expect(subject.loan_valid?).to be_falsey
      end
    end

    context "more than maximum set value" do
      let(:loan) { 16_000 }
      it "raises an error" do
        expect(subject.loan_valid?).to be_falsey
      end
    end

    context "not an increment of 100" do
      let(:loan) { 1101 }
      it "raises an error" do
        expect(subject.loan_valid?).to be_falsey
      end
    end

    context "not an integer" do
      let(:loan) { "Boom" }
      it "raises an error" do
        expect { subject.loan_valid? }.to raise_error(ArgumentError)
      end
    end
  end
end
