require 'rails_helper'

describe ProjectsController do

  render_views

  before(:all) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
  end

  context "json request to" do
    context "index" do
      xit "returns properly formatted data" do
        get :index, format: :json
        response = JSON.parse(response.body)
        expect(response.size).to eq(Project.count)
        expect(response[0].keys).to eq(%(id status user route grade))
      end
    end
  end
end
