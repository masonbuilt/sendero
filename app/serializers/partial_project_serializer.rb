class PartialProjectSerializer < GenericSerializer
  
  class << self
    def original_attributes
      [:id, :status, :user, :route, :grade]
    end

    def addons
      { 
        "user" => "string",
        "route" => "string",
        "grade" => "string"
      }
    end
  end

  attributes *original_attributes

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