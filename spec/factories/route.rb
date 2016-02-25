FactoryGirl.define do
  factory :route do
    grade { FactoryGirl.create(:grade) }
    owner { FactoryGirl.create(:user) }
    name { "Slippery Crack" }
    info { "Route detail goes here" }
  end
end