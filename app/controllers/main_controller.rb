class MainController < ApplicationController
  def dashboard
  	@routes = current_user.routes.limit(5) rescue []
  	@projects = current_user.projects.limit(5) rescue []
  	@comments = current_user.comments.limit(5) rescue []
  end
end