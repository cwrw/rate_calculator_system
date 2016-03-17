require "spec_helper"
RSpec.feature 'Rate calculator system', type: feature do
  let(:path) { File.dirname(__FILE__) }
  let(:market_data) do
    File.open(File.join(path, "../support/fixtures/market_data.csv"))
  end
  let(:invalid_data) do
    File.open(File.join(path, "../support/fixtures/invalid_data.csv"))
  end

  xcontext "valid data" do
    context "loan within range" do
      scenario "outputs lowest rate details" do
        RateCalculatorSystem.calculate(market_data, "1100")
      end
    end

    context "loan out of range" do
      scenario "outputs relevant out of range message when less" do
        RateCalculatorSystem.calculate(market_data, "900")
      end

      scenario "outputs relevant out of range message when more" do
        RateCalculatorSystem.calculate(market_data, "15100")
      end
    end
  end

  xcontext "invalid data" do
    context "market data" do
      scenario "outputs relevant message" do
        RateCalculatorSystem.calculate(invalid_data, "1100")
      end
    end

    context "requested loan" do
      scenario "outputs relevant message" do
        RateCalculatorSystem.calculate(market_data, "Boom")
      end
    end
  end
end
