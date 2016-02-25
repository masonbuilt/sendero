class GenericSerializer < ActiveModel::Serializer
  class << self

    def json_manifest
      raise StandardError, "Must provide an ActiveRecord class to this method" if resource_class.nil?
      raise StandardError, "Cannot call this method on the superclass" if self == GenericSerializer
      JSONManifest.produce(resource_class, *original_attributes).merge(addons)
    end

    def original_attributes
      if self != GenericSerializer
        raise StandardError, "You must implement #{__method__} on #{self}, with all attributes to serialize. E.g., [:id, :name]"
      end
    end

    # Tack on additional values not stored in this resource's DB table
    # Order must match up with `attributes` method(A)
    def addons
      if self != GenericSerializer
        raise StandardError, "You must implement #{__method__} on #{self}, with all attributes not on #{self}'s table, in order.  See #{__FILE__} for documentation."
      end
    end

    private

    def resource_class
      resource_class_name = /Partial(\w+)Serializer/.match(self.to_s)[1]
      Object.const_get(resource_class_name)
    rescue NameError => e
      puts e.message
      puts e.backtrace
      raise StandardError, "Could not properly infer resource class name from the serializer's class.  Please rename this class accordingly."
    end
  end
  
  attributes *self.attributes
end

# (A)

# If attributes is [:foo, :bar, :baz, :qux] and only :foo and :bar
# are columns on that resource,

# Then the order of keys in `addons` should be:
#   {
#     "baz" => "baz data type",
#     "qux" => "qux data type"
#   }

# If there are no additional attributes, just define it as an empty Hash ({})