require 'rails_helper'

class TestPartialRouteSerializer < GenericSerializer
  def self.original_attributes
    [:id, :name, :owner]
  end

  def self.addons
    {"owner" => "string"}
  end

  private

  def owner
    object.owner.name
  end
end

class MissingOriginalAttributesPartialRouteSerializer < GenericSerializer

  def self.addons
    {"owner" => "string"}
  end

  private

  def owner
    object.owner.name
  end
end

class MissingAddonsPartialRouteSerializer < GenericSerializer
  def self.original_attributes
    [:id, :name, :owner]
  end

  private

  def owner
    object.owner.name
  end
end



RSpec.describe GenericSerializer do
  context "inheritance" do

    before(:all) do
      @user = User.create(
        first_name: "Foo",
        last_name: "Bar",
        age: 22,
        password: "password",
        password_confirmation: "password",
        email: "foo@bar.com"
        )

      @route = Route.create(
        name: "Slippery Crack",
        info: "info",
        grade_id: 1,
        owner_id: @user.id
        )
    end

    context "success" do
      it "should return a JSON manifest properly" do
        expected_manifest = {"id" => "number", "name" => "string", "owner" => "string"}
        expect(TestPartialRouteSerializer.json_manifest).to eq(expected_manifest)
      end

      it "should evaluate the table name correctly" do
        expect(TestPartialRouteSerializer.send(:resource_class)).to eq(Route)
      end
    end

    context "failure" do
      it "should give an error if #self.original_attributes not implemented" do
        expect do
          MissingOriginalAttributesPartialRouteSerializer.json_manifest
        end.to raise_error("You must implement original_attributes on MissingOriginalAttributesPartialRouteSerializer, with all attributes to serialize. E.g., [:id, :name]")
      end

      it "should give an error if #self.addons not implemented" do
        begin
          MissingAddonsPartialRouteSerializer.json_manifest
        rescue => e
          expect(e.message).to eq("You must implement addons on MissingAddonsPartialRouteSerializer, with all attributes not on MissingAddonsPartialRouteSerializer's table, in order.  See /home/michael/Sites/sendero/app/serializers/generic_serializer.rb for documentation.")
        end
      end
    end
  end
end