json.array!(@grades) do |grade|
  json.extract! grade, :id, :value, :name
  json.url grade_url(grade, format: :json)
end
