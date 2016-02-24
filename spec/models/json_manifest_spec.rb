require 'rails_helper'

RSpec.describe JSONManifest, type: :model do
  context "success" do
    it "works for User" do
      expected_hash = {"id" => "number", "first_name" => "string"}
      expect(JSONManifest.produce(User, :id, :first_name)).to eq(expected_hash)
    end

    it "works for Route" do
      expected_hash = {"id" => "number", "name" => "string"}
      expect(JSONManifest.produce(Route, :id, :name)).to eq(expected_hash)
    end
  end
end
