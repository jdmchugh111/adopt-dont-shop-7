class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
    # @application = Application.find(params[:id])
  end

  def create
    application = Application.new(application_params)
    application.save

    redirect_to "/applications/#{application.id}"
  end

private
  def application_params
    full_address = "#{params[:street_address]} #{params[:city]}, #{params[:state]} #{params[:zip]}"
    params[:address] = full_address
    params[:status] = "In Progress"
    params.permit(:id, :name, :address, :description, :status)
  end
end