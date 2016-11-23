class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all
  end

  def show
    @currencies = Currency.all
    @current_currency = @currencies.detect { |c| c.id == params[:id].to_i }
    @rates = @current_currency.from_rates
  end
end
