class Grade < ActiveRecord::Base
	has_many :routes
  has_many :projects, through: :routes
end
