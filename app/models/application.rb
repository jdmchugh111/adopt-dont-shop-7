class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true

  def pet_to_adopt(pet_id) #pet_id coming through as nil, still need to figure out
    # return if pet_id.nil?
    wanted_pet = Pet.find_by(id: pet_id)
    # require 'pry';binding.pry
    # pets << wanted_pet
    # require 'pry';binding.pry
  end

  def status_to_pending
    update(status: "Pending")
  end
end