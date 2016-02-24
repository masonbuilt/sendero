class PartialProjectSerializer < ActiveModel::Serializer
  
  ATTRIBUTES = [:id, :status, :user, :route, :grade] # Order sensitive
  ADDONS = { # Not stored in this table
            "user" => "character varying",
            "route" => "character varying",
            "grade" => "character varying"
          }

  class << self

    def json_manifest
      JSONManifest.produce(Project, *ATTRIBUTES).merge(ADDONS)
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