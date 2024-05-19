class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true

  def status_to_pending
    update(status: "Pending")
  end
end