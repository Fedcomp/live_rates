Rails.application.routes.draw do
  root "currencies#index"

  resources :currencies, only: :index do
    # Subject to discussion
    intervals = Rails.application.config.currency_rate_intervals.keys.join("|")
    default_interval = Rails.application.config.currency_rate_default_interval

    # Imitate show with additional param
    get "(/:interval)" => :show,
        on: :member,
        as: "",
        constraints: { interval: Regexp.new(intervals) },
        defaults: { interval: default_interval.to_s }
  end
end
