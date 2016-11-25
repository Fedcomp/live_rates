# Time sensitive test
RSpec.configure do |config|
  config.before time: :freeze do
    Timecop.freeze
  end

  config.after time: :freeze do
    Timecop.return
  end
end
