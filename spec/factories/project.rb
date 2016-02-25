FactoryGirl.define do
  factory :project do
    status { "active" }
    user { FactoryGirl.create(:user) }
    route { FactoryGirl.create(:route) }
  end
end