class ProjectSerializer < ActiveModel::Serializer
  attributes  :id,
              :status

  has_one :user, serializer: PartialUserSerializer
  has_one :route, serializer: PartialRouteSerializer
  has_one :grade, serializer: PartialGradeSerializer
end