class CommentsController < ApplicationController
  def index
    @comments = current_user.try(:comments) || []
  end
end