module CurrenciesHelper
  OPTIMAL_CHART_POINTS = 50

  def rate_chart_for_currency(currency, rates)
    elements = rates.select { |r| r.to_currency_id == currency.id }

    line_chart [
      { name: :buy,  data: optimize_chart(elements.map { |e| [e.created_at, e.buy]  }) },
      { name: :sell, data: optimize_chart(elements.map { |e| [e.created_at, e.sell] }) }
    ]
  end

  private

  # out of ideas how to optimize it for rubocop
  # rubocop:disable Metrics/AbcSize
  def optimize_chart(data)
    scale = data.count / OPTIMAL_CHART_POINTS
    return data unless scale >= 2

    data.each_slice(scale).map do |slice|
      [
        # average time between first and last positions of slice
        slice.first.first + ((slice.last.first - slice.first.first).to_f / 2),
        (slice.map(&:last).sum / slice.count)
      ]
    end
  end
end
