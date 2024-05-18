class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets_search_name = params[:search_name].present? ? Pet.search(params[:search_name]) : false
  end

  def new
    # @application = Application.find(params[:id])
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new", alert: "Please fill in answers to all prompts"
    end
  end

private
  def application_params
    full_address = "#{params[:street_address]} #{params[:city]}, #{params[:state]} #{params[:zip]}"
    params[:address] = full_address
    params[:status] = "In Progress"

    params.permit(:id, :name, :address, :description, :status)
  end
end