FactoryGirl.define do
  factory :currency do
    code { (0...3).map { (65 + rand(26)).chr }.join }
  end
end
