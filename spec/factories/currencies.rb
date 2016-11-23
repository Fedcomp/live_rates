FactoryGirl.define do
  factory :currency do
    sequence(:code) do |n|
      range = ("A".."Z").to_a
      postfix = (0...2).map { range.sample }.join
      "#{range[n]}#{postfix}"
    end
  end
end
