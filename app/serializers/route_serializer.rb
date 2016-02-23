class RouteSerializer < ActiveModel::Serializer
  attributes  :id,
              :name,
              :info,
              :created_at,
              :projects

  has_one  :owner, serializer: PartialUserSerializer
  has_many :projects, serializer: PartialProjectSerializer
  has_one  :grade, serializer: PartialGradeSerializer

end
