class MainController < ApplicationController
  def dashboard
  	@routes = current_user.routes.limit(5)
  	@projects = current_user.projects.limit(5)
  	@comments = current_user.comments.limit(5)
  end
end