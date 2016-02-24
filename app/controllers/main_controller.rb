class MainController < ApplicationController
	before_action :redirect_to_login, if: -> { current_user.nil? }, except: :landing

  def dashboard
  end

  def landing
  end

  private

  def redirect_to_login
  	redirect_to new_user_session_path
  end
end