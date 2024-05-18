require "rails_helper"

RSpec.describe "Application Show Page" do
  before(:each) do
    @application_1 = Application.create!(name: "James", address: "123 Main Street", description: "I want a doggie", status: "In Progress")
    @application_2 = Application.create!(name: "Zach", address: "123 Rome Street", description: "I want two doggies", status: "In Progress")

    @shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id) 

    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_2.id)
  end

  describe "As a visitor" do
    describe "When I visit the applications show page" do
      it "it shows the application attributes" do
        visit("/applications/#{@application_1.id}")

        expect(page).to have_content("James")
        expect(page).to have_content("123 Main Street")
        expect(page).to have_content("I want a doggie")
        expect(page).to have_content("In Progress")

        expect(page).to have_link("Lucille Bald")
      end

      it "directs to pet show pages when link is clicked" do
        visit("/applications/#{@application_1.id}")

        click_link("Lucille Bald")

        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end

      it "shows a section to Add a Pet to this Application, that is used to search for pets" do
        ApplicationPet.destroy_all

        visit("/applications/#{@application_1.id}")

        expect(page).to have_content("Add a Pet to this Application")
        fill_in(:search_name, with: "Lucille Bald")
        click_on("Submit")

        expect(current_path).to eq("/applications/#{@application_1.id}")

        expect(page).to have_content("#{@pet_1.name}")
        expect(page).to have_content("#{@pet_1.age}")
        expect(page).to have_content("#{@pet_1.breed}")
        expect(page).to have_content("#{@pet_1.adoptable}")
      end

      it "Sad Path: displays a message if no pets were found by name search" do
        ApplicationPet.destroy_all

        visit("/applications/#{@application_1.id}")

        expect(page).to have_content("Add a Pet to this Application")
        fill_in(:search_name, with: "Doggie")
        click_on("Submit")

        expect(current_path).to eq("/applications/#{@application_1.id}")

        expect(page).to have_content("No pets were found with that name")
      end
    end
  end


end