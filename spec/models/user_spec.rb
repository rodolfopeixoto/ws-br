require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  describe "respond" do
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:auth_token) }
    it { should be_valid }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { should validate_confirmation_of(:password) }
    it { should allow_value('example@domain.com').for(:email) }
    it { should validate_uniqueness_of(:auth_token) }
  end

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      expect(Devise).to receive(:friendly_token).and_return("authuniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql("authuniquetoken123")
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "authuniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql(existing_user.auth_token)
    end
  end

  describe "Associations" do
    it { should have_many(:properties) }
  end

  describe "#properties association" do
    before do
      @user.save
      3.times { FactoryGirl.create :property, user: @user }
    end

    it "destroys the associated propertieson self destruct" do
      properties = @user.properties
      @user.destroy
      properties.each do |property|
        expect(Property.find(property)).to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
