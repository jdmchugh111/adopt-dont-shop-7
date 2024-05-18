class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets.distinct
    @pets_search_name = params[:search_name].present? ? Pet.search(params[:search_name]) : false
    @wanted_pet = @application.pet_to_adopt(params[:pet_to_adopt_id])
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

  def update
    @application = Application.find(params[:id])
    @application.update(application_params)
    @application.status_to_pending

    redirect_to "/applications/#{params[:id]}"
  end

private
  def application_params
    full_address = "#{params[:street_address]} #{params[:city]}, #{params[:state]} #{params[:zip]}"
    params[:address] = full_address
    params[:status] = "In Progress"

    params.permit(:id, :name, :address, :description, :status)
  end
end