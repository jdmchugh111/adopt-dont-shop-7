require "rails_helper"

RSpec.describe "the shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @application_1 = Application.create!(name: "James", address: "123 Main Street", description: "I want a doggie", status: "In Progress")
    @application_2 = Application.create!(name: "Zach", address: "123 Rome Street", description: "I want two doggies", status: "In Progress")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_2.id)
  end

  it "lists all the shelter names" do
    visit "/admin/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it "lists shelters in reverse alphabetical order" do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it "shows shelters with pending applications" do
    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")
    expect(page).to have_content(@shelter_1.name, count: 2)
  end
end