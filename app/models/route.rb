class Route < ActiveRecord::Base
	belongs_to :grade
	has_many :users, through: :projects
	has_many :comments
end
