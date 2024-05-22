class AddPetStatusToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :application_pets, :pet_status, :string
  end
end
