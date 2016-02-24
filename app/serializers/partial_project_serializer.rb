class PartialProjectSerializer < ActiveModel::Serializer
  
  ATTRIBUTES = [:id, :status, :user, :route, :grade]

  class << self

    def json_manifest
      JSONManifest.produce(Project, *ATTRIBUTES)
    end
  end

  attributes *PartialProjectSerializer::ATTRIBUTES

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