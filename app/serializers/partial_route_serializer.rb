class PartialRouteSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :grade,
              :owner_id

  private

  def grade
    object.grade.name
  end

end