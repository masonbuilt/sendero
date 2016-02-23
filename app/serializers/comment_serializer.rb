class CommentSerializer < ActiveModel::Serializer
  attributes  :id,
              :body,
              :created_at,
              :user,
              :route

  private

  def user
    object.user.name
  end

  def route
    object.route.name
  end
end