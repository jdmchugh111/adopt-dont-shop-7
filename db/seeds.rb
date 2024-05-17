# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

application_1 = Application.create!(name: "James", address: "123 Main Street", description: "I want a doggie", status: "In Progress")
application_2 = Application.create!(name: "Zach", address: "123 Rome Street", description: "I want two doggies", status: "In Progress")

shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

pet_1 = Pet.create(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: shelter.id)
pet_2 = Pet.create(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: shelter.id)

ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)
ApplicationPet.create!(pet_id: pet_2.id, application_id: application_2.id)
ApplicationPet.create!(pet_id: pet_1.id, application_id: application_2.id)
