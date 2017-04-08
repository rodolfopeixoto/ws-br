class Property < ApplicationRecord
  validates :title, :user_id, :accommodates, :bathrooms, :number_of_rooms, :description, :description,  presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :user
end