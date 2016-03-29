require "spec_helper"

RSpec.describe RateCalculatorSystem::Calculator do
  let(:lenders) do
    [
      RateCalculatorSystem::Lender.new(name: "Bob", rate: 0.075, amount: 640, maximum_exposure: 300),
      RateCalculatorSystem::Lender.new(name: "Jane", rate: 0.069, amount: 480, maximum_exposure: 400),
      RateCalculatorSystem::Lender.new(name: "Fred", rate: 0.071, amount: 520, maximum_exposure: 100),
      RateCalculatorSystem::Lender.new(name: "Mary", rate: 0.104, amount: 170, maximum_exposure: 130),
      RateCalculatorSystem::Lender.new(name: "John", rate: 0.081, amount: 320, maximum_exposure: 200),
      RateCalculatorSystem::Lender.new(name: "Dave", rate: 0.074, amount: 140, maximum_exposure: 100),
      RateCalculatorSystem::Lender.new(name: "Angela", rate: 0.071, amount: 60, maximum_exposure: 20)
    ]
  end

  subject { described_class.new(loan, lenders) }

  describe "loan_valid?" do
    let(:loan) { 1100 }
    it "returns true if loan is valid" do
      expect(subject.loan_valid?).to be_truthy
    end

    context "less than minimum set value" do
      let(:loan) { 900 }
      it "returns false" do
        expect(subject.loan_valid?).to be_falsey
      end
    end

    context "more than maximum set value" do
      let(:loan) { 16_000 }
      it "returns false" do
        expect(subject.loan_valid?).to be_falsey
      end
    end

    context "not an increment of 100" do
      let(:loan) { 1101 }
      it "returns false" do
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

  describe "funds_available?" do
    context "loan is more than available funds" do
      let(:loan) { 5000 }
      it "returns false" do
        expect(subject.funds_available?).to be_falsey
      end
    end

    context "loan is less than available funds" do
      let(:loan) { 1100 }
      it "returns true" do
        expect(subject.funds_available?).to be_truthy
      end
    end
  end

  describe "final_rate" do
    let(:message) do
      %(
        Requested amount: £#{loan}
        Rate: #{rate}%
        Monthly repayment: £#{monthly_payment}
        Total repayment: £#{total_payment}
      )
    end

    context "loan amount less than one lender amount and maximum exposure is less than loan" do
      let(:lenders) do
        [
          RateCalculatorSystem::Lender.new(name: "Bob", rate: 0.075, amount: 1640, maximum_exposure: 900),
          RateCalculatorSystem::Lender.new(name: "John", rate: 0.081, amount: 320, maximum_exposure: 200)
        ]
      end

      let(:loan) { 1000 }
      let(:rate) { 7.6 }
      let(:monthly_payment) { 103.70 }
      let(:total_payment) { 1244.39 }

      it "outputs correct rate and totals in message" do
        expect(subject.final_rate).to eq(message)
      end
    end

    context "loan amount less than one lender amount and maximum exposure equal to amount" do
      let(:lenders) do
        [
          RateCalculatorSystem::Lender.new(name: "Bob", rate: 0.075, amount: 1640, maximum_exposure: 1640),
          RateCalculatorSystem::Lender.new(name: "John", rate: 0.081, amount: 320, maximum_exposure: 200)
        ]
      end

      let(:loan) { 1000 }
      let(:rate) { 7.5 }
      let(:monthly_payment) { 103.53 }
      let(:total_payment) { 1242.30 }

      it "outputs correct rate and totals in message" do
        expect(subject.final_rate).to eq(message)
      end
    end

    context "loan amount more than one lender amount" do
      let(:loan) { 1100 }
      let(:rate) { 7.3 }
      let(:monthly_payment) { 113.33 }
      let(:total_payment) { 1360.01 }

      it "outputs correct rate and totals in message" do
        expect(subject.final_rate).to eq(message)
      end
    end

    context "loan amount equal to one lender amount" do
      let(:lenders) do
        [
          RateCalculatorSystem::Lender.new(name: "Bob", rate: 0.075, amount: 6400, maximum_exposure: 6400),
          RateCalculatorSystem::Lender.new(name: "John", rate: 0.081, amount: 320, maximum_exposure: 320)
        ]
      end

      let(:loan) { 6400 }
      let(:rate) { 7.5 }
      let(:monthly_payment) { 662.56 }
      let(:total_payment) { 7950.70 }
      it "outputs correct rate and totals in message" do
        expect(subject.final_rate).to eq(message)
      end
    end

    context "exceptions" do
      context "loan not valid" do
        let(:loan) { 800 }
        it "raises invalid loan error" do
          expect { subject.final_rate }.to raise_error(RateCalculatorSystem::InvalidLoanError)
        end
      end

      context "funds not available" do
        let(:loan) { 2400 }
        it "raises no funds error" do
          expect { subject.final_rate }.to raise_error(RateCalculatorSystem::NoFundsError)
        end
      end
    end
  end
end
