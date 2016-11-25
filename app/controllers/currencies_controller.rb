class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all
  end

  def show
    @current_interval = params[:interval].to_sym
    @current_currency, @to_currencies = currencies
    @rates = rates_by_interval
  end

  private

  # @return [Array] Current currency and currencies to match against
  def currencies
    to_currencies = Currency.all
    current_currency = to_currencies.detect { |c| c.id == params[:id].to_i }
    to_currencies -= [current_currency]
    [current_currency, to_currencies]
  end

  def rates_by_interval
    @current_currency.from_rates.where(created_at: current_interval)
  end

  def current_interval
    interval = Rails.application
                    .config
                    .currency_rate_intervals[@current_interval]

    interval.seconds.ago..Time.current
  end
end
