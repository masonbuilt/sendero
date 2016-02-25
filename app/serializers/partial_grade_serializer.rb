class PartialGradeSerializer < GenericSerializer

  class << self
    def original_attributes
      [:id, :name, :value]
    end

    def addons
      {}
    end
  end

  attributes *self.original_attributes
end