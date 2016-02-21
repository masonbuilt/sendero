class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :route

	validates_presence_of :user
end
