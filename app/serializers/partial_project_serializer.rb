class PartialProjectSerializer < ActiveModel::Serializer
  attributes  :id,
              :status,
              :user,
              :route,
              :grade

  private

  def user
    object.user.name
  end

  def route
    object.route.name
  end

  def grade
    object.grade.name
  end
end