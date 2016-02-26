class Route < ActiveRecord::Base
	belongs_to :grade
	has_many :users, through: :projects
	has_many :projects
	has_many :comments
	belongs_to :owner, class_name: "User", foreign_key: "owner_id"

	validates_presence_of :grade_id
	validates_presence_of :owner_id
  validates_numericality_of :grade_id

  after_save :load_into_soulmate

  def load_into_soulmate
    loader = Soulmate::Loader.new("route")
    loader.add(
      "term" => name,
      "id" => id,
      "grade" => grade.name,
      "url" => Rails.application.routes.url_helpers.route_path(self)
      )
  end

  def remove_from_soulmate
    loader = Soulmate::Loader.new("route")
    loader.remove("id" => id)
  end

  def self.search(term)
    matches = Soulmate::Matcher.new('route').matches_for_term(term)
    matches.collect do |match|
      {
        "id" => match["id"],
        "label" => match["term"],
        "value" => match["term"],
        "grade" => match["grade"],
        "url" => match["url"]
      }
    end
  end
end
