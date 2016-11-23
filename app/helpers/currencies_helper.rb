module CurrenciesHelper
  def rate_chart_for_currency(currency, rates)
    elements = rates.select { |r| r.to_currency_id == currency.id }
    plot_data = [:buy, :sell].map do |direction|
      # data => value
      direction_data = elements.map do |e|
        { e.created_at => e.send(direction) }
      end.reduce({}, :merge)

      { name: direction, data: direction_data }
    end

    line_chart plot_data, min: 0.8
  end
end
