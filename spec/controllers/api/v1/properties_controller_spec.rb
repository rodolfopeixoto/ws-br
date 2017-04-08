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


  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @property_attributes = FactoryGirl.attributes_for :property
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, property: @property_attributes}
      end

      it "renders the json representation for the property record just created" do
        property_response = json_response
        expect(property_response[:title]).to eql(@property_attributes[:title])
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_property_attributes = { title: "Busco Republica", price: 'Twelve dollars'}
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, property: @invalid_property_attributes }
      end

      it "renders an errors json" do
        property_response = json_response
        expect(property_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        property_response = json_response
        expect(property_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end
end
