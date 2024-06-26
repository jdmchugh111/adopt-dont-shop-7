class AdminApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.find(params[:id])
    
    application_pet.update(pet_status: params[:status])

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end