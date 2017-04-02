require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.ws-br.v1, #{Mime[:json]}"}
  before(:each) { request.headers['Content-Type'] = Mime[:json].to_s }

  describe "GET show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, params: { id: @user.id }, format: :json
    end

    it "returns the information about a reporter on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eql(@user.email)
    end

    it { should respond_with 200 }

  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, params: { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql(@user_attributes[:email])
      end

      it { should respond_with 201 }
    end

   context "when is not created" do
     before(:each) do
       @invalid_user_attributes = { password: "12345678",
                                   password_confirmation: "12345678" }
       post :create, params: { user: @invalid_user_attributes }, format: :json
     end
   it "renders an errors json" do
     user_response = json_response
     expect(user_response).to have_key(:errors)
   end

   it "renders the json errors on why the usercould not be created" do
    user_response = json_response
    expect(user_response[:errors][:email]).to include "can't be blank"
   end

   it { should respond_with 422 }
   end

  end

  describe "PUT/PATCH #update" do

    before(:each) do
        @user = FactoryGirl.create(:user)
        api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { id: @user.id,
                                user: { email: "example2@example.com" } }, format: :json
      end

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql("example2@example.com")
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, params: { id: @user.id,
                         user: { email: "bademailsx.com" } }, format: :json
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be updated" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end

    describe "DELETE #destroy" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        api_authorization_header @user.auth_token
        delete :destroy, params: { id: @user.id }, format: :json
      end

      it { should respond_with 204}
    end
  end
end
