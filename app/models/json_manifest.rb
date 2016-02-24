# JSONManifest.produce(User, :id, :first_name)

# {
#   "id": "number",
#   "first_name": "string"
# }

class JSONManifest

  class << self
    DEREFERENCE_TABLE = {
      "integer" => "number",
      "character varying" => "string",
      "timestamp without time zone" => "string",
      "text" => "string"
    }

    def produce(klass, *attributes)
      dereference(attribute_types(klass).slice(*attributes))
    end

    def attribute_types(klass)
      attributes = klass.columns_hash.map(&:first)
      types = klass.columns_hash.map(&:last).map(&:sql_type)
      HashWithIndifferentAccess[attributes.zip(types)]
    end

    def dereference(attribute_types)
      attribute_types.inject({}) do |collector, (attr, type)|
        collector[attr] = DEREFERENCE_TABLE[type]
        collector
      end
    end
  end

end