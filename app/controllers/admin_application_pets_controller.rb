class AdminApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.find(params[:id])
    
    application_pet.application.update(status: params[:status])

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end