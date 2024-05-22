class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets.distinct
    @pets_search_name = params[:search_name].present? ? Pet.search(params[:search_name]) : nil
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Please fill in answers to all prompts"
      render :new
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.status_to_pending
    @application.update(pet_description: params[:pet_description])

    redirect_to "/applications/#{params[:id]}"
  end

private
  def application_params
    full_address = "#{params[:street_address]} #{params[:city]}, #{params[:state]} #{params[:zip]}"
    params[:address] = full_address
    params[:status] = "In Progress"

    params.permit(:id, :name, :address, :description, :status, :pet_description)
  end
end