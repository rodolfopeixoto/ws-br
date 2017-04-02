require 'rails_helper'

RSpec.describe Property, type: :model do

  let(:property) { FactoryGirl.build :property }
  subject { property }

  describe 'Property respond' do
    it { should respond_to(:title) }
    it { should respond_to(:accommodates) }
    it { should respond_to(:bathrooms) }
    it { should respond_to(:number_of_rooms) }
    it { should respond_to(:furnished) }
    it { should respond_to(:price) }
    it { should respond_to(:description) }
    it { should respond_to(:published) }
    it { should respond_to(:user_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:accommodates) }
    it { should validate_presence_of(:bathrooms) }
    it { should validate_presence_of(:number_of_rooms) }
    it { should validate_presence_of(:price)}
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:user_id)}
  end

end
