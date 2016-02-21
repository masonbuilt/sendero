class Route < ActiveRecord::Base
	belongs_to :grade
	has_many :users, through: :projects
	has_many :comments
	belongs_to :owner, class_name: "User", foreign_key: "owner_id"

	validates_presence_of :grade
	validates_presence_of :owner_id
end
