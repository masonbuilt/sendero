class GradeSerializer < ActiveModel::Serializer
  attributes  :id,
              :value,
              :name

  has_many :routes, serializer: PartialRouteSerializer
  has_many :projects, serializer: PartialProjectSerializer
end