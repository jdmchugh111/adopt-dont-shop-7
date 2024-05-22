class AddPetDescriptionToApplications < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :pet_description, :text
  end
end
