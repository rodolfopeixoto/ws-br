class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def index
    respond_with Property.all
  end

  def show
    respond_with Property.find(params[:id])
  end

  def create
    property = current_user.properties.build(property_params)
    if property.save
      render json: property, status: 201, location: [:api, property]
    else
      render json: { errors: property.errors }, status: 422
    end
  end

  private

    def property_params
      params.require(:property).permit(:title,:accommodates,:bathrooms,:number_of_rooms, :price, :published, :description)
    end
end