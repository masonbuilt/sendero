class UserSerializer < ActiveModel::Serializer
  attributes  :id,
              :first_name,
              :last_name,
              :age,
              :email

  has_many :routes, serializer: PartialRouteSerializer
  has_many :projects, serializer: PartialProjectSerializer
end