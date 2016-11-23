currencies = { USD: "$", EUR: "€" }

currencies.each do |code, symbol|
  Currency.find_or_create_by(code: code, symbol: symbol)
end
