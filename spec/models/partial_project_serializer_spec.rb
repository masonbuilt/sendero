require 'rails_helper'

RSpec.describe PartialProjectSerializer do
  context "json manifest" do

    EXPECTED_VALUES = {
      "id"=>"number", 
      "status"=>"string",
      "user"=>"string",
      "route"=>"string",
      "grade"=>"string"
    }

    it "returns the expected values" do

      expect(PartialProjectSerializer.json_manifest).to eq(EXPECTED_VALUES)
    end
  end
end
