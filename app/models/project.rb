class Project < ActiveRecord::Base
	# belongs_to :user, class: User
	belongs_to :route, class: Route
end
