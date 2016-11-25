after :currencies do
  next if CurrencyRate.count.positive?

  currencies = Currency.all
  week_ago = 1.week.ago.beginning_of_day
  points_amount = 1.week / 15.minutes

  points = Array.new(points_amount) do |i|
    # Find current point date
    date = Time.at(week_ago.to_i + (15.minutes * i))
    sell = 0.9 + rand(-0.001..0.001)
    buy = sell - rand(0.01..0.011)

    currencies.to_a.permutation.map do |from_currency, to_currency|
      {
        from_currency: from_currency,
        to_currency: to_currency,
        buy: buy,
        sell: sell,
        created_at: date,
        updated_at: date
      }
    end
  end.flatten

  points.each do |point|
    # slow, but good enough for local development
    CurrencyRate.find_or_create_by!(point)
  end
end
