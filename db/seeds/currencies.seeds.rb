%w(USD EUR).each do |currency_code|
  Currency.find_or_create_by(code: currency_code)
end
