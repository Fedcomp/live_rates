class CurrenciesController < ApplicationController
  def index
    @currencies = Currency.all
  end

  def show
    @currencies = Currency.all
    @current_currency = @currencies.detect { |c| c.id == params[:id].to_i }
    @rates = rates_by_interval
  end

  private

  def rates_by_interval
    interval = intervals[params[:interval].to_sym]
    @current_currency.from_rates.where(created_at: interval)
  end

  def intervals
    {
      six_hours:  6.hours.ago..Time.current,
      daily:      1.day.ago..Time.current,
      weekly:     1.week.ago..Time.current
    }
  end
end
