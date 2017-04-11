class Api::V1::PropertiesController < ApplicationController
  before_action :authenticate_with_token!, only: [:create,:update]
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

  def update
    property = current_user.properties.find(params[:id])
    if property.update(property_params)
      render json: property, status: 200, location: [:api, property]
    else
      render json: { errors: property.errors }, status: 422
    end
  end

  def destroy
    property = current_user.properties.find(params[:id])
    property.destroy
    head 204
  end

  private

    def property_params
      params.require(:property).permit(:title,:accommodates,:bathrooms,:number_of_rooms, :price, :published, :description)
    end
end