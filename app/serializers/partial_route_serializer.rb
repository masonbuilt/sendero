class PartialRouteSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :grade

  private

  def grade
    object.grade.name
  end

end