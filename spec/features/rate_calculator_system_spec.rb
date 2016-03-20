require "spec_helper"

RSpec.feature 'Rate calculator system', type: feature do
  let(:path) { File.dirname(__FILE__) }
  let(:market_data) do
    File.join(path, "../support/fixtures/market_data.csv")
  end

  let(:invalid_data) do
    File.join(path, "../support/fixtures/invalid_data.csv")
  end

  let(:invalid_header) do
    File.join(path, "../support/fixtures/invalid_header.csv")
  end

  subject { RateCalculatorSystem.calculate(market_data, loan) }

  context "valid data" do
    let(:message) do
      %r{
        Requested amount: £1100
        Rate: 7.0%
        Monthly repayment: £112.37
        Total repayment: £1348.45
      }
    end
    context "loan within range" do
      let(:loan) { "1100" }
      scenario "outputs lowest rate details" do
        expect { subject }.to output(message).to_stdout
      end
    end

    context "loan out of range" do
      let(:loan) { "15_100" }
      let(:message) do
        %r{Invalid loan value}
      end

      scenario "outputs relevant out of range message" do
        expect { subject }.to output(message).to_stdout
      end
    end

    context "not enought funds available" do
      let(:loan) { "3000" }
      let(:message) do
        %r{There aren't enough funds to satisfy the loan value}
      end

      scenario "outputs relevant no funds message" do
        expect { subject }.to output(message).to_stdout
      end
    end
  end

  context "invalid data" do
    context "market data" do
      let(:loan) { "1100" }

      scenario "outputs relevant invalid file message" do
        expect { RateCalculatorSystem.calculate(invalid_data, loan) }.to output(%r{invalid value for Float}).to_stdout
      end

      scenario "outputs relevant invalid header message" do
        expect { RateCalculatorSystem.calculate(invalid_header, loan) }.to output(%r{Invalid Header in CSV file}).to_stdout
      end
    end

    context "requested loan" do
      let(:loan) { "Boom" }
      let(:message) do
        %r{invalid value for Float}
      end
      scenario "outputs relevant message" do
        expect { subject }.to output(message).to_stdout
      end
    end
  end
end
