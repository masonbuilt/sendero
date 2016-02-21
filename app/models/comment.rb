class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :route

	validates_presence_of :user
	validates_presence_of :route
end
