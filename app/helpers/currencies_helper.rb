module CurrenciesHelper
  OPTIMAL_CHART_POINTS = 50

  def rate_chart_for_currency(currency, rates)
    elements = rates.select { |r| r.to_currency_id == currency.id }
    plot_data = [:buy, :sell].map do |direction|
      # data => value
      direction_data = elements.map do |e|
        { e.created_at => e.send(direction) }
      end.reduce({}, :merge)

      if direction_data.count > OPTIMAL_CHART_POINTS &&
         direction_data.count / OPTIMAL_CHART_POINTS >= 2
        scale = direction_data.count / OPTIMAL_CHART_POINTS

        direction_data = direction_data.each_slice(scale).map do |slice|
          slice = Hash[slice]

          average_time = Time.at(slice.keys.map(&:to_f).sum / slice.count)
          average_value = slice.values.sum / slice.count

          { average_time => average_value }
        end.reduce({}, :merge)
      end

      { name: direction, data: direction_data }
    end

    line_chart plot_data
  end
end
