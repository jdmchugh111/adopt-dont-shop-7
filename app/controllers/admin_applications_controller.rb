class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.application_pets
  end
end