class ApplicationPetsController < ApplicationController
    def create
        @application = Application.find(params[:id])
        @pet = Pet.find(params[:pet_to_adopt_id])
        ApplicationPet.create(application_id: @application.id, pet_id: @pet.id)

        redirect_to "/applications/#{params[:id]}"
    end
end