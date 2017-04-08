require 'rails_helper'

RSpec.describe Api::V1::PropertiesController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @property = FactoryGirl.create(:property)
      get :show, params: { id: @property.id }, format: :json
    end

    it "return the information about a reporter on a hash" do
      property_response = json_response
      expect(property_response[:title]).to eql @property.title
    end

    it { should respond_with 200 }
  end


  describe "Get #index" do
    before(:each) do
      4.times { FactoryGirl.create(:property) }
      get :index, format: :json
    end

    it "returns 4 records from database" do
      properties_response = json_response
      expect(properties_response.length).to eql(4)
    end

    it { should respond_with 200 }
  end
end
