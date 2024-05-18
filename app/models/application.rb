class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true

  def pet_to_adopt(pet_id)
    return if pet_id.nil?

    Pet.find_by(id: pet_id)
  end
end