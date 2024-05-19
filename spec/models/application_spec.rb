require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets)}
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
  end

  before(:each) do
    @application = Application.create!(name: "James", address: "123 Main Street", description: "I want a doggie", status: "In Progress")
    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @pet = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
  end

  describe "instance methods" do
    describe ".status_to_pending" do
      it "changes the status of the application instance to pending" do
        expect(@application.status).to eq("In Progress")

        @application.status_to_pending

        expect(@application.status).to eq("Pending")
      end
    end
  end
end