class Api::V1::PropertiesController < ApplicationController
  respond_to :json

  def index
    respond_with Property.all
  end

  def show
    respond_with Property.find(params[:id])
  end
end
