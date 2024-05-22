require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  before(:each) do
    @application_1 = Application.create!(name: "James", address: "123 Main Street", description: "I want a doggie", status: "In Progress")
    @application_2 = Application.create!(name: "Zach", address: "123 Rome Street", description: "I want two doggies", status: "In Progress")

    @shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Lucille Bald", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: "doberman", name: "Lobster", shelter_id: @shelter.id) 
    # @pet_3 = Pet.create(adoptable: true, age: 5, breed: "golden retriever", name: "Goldie", shelter_id: @shelter.id) 
    # @pet_4 = Pet.create(adoptable: true, age: 6, breed: "Pitbull", name: "Princess", shelter_id: @shelter.id) 

    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
    # ApplicationPet.create!(pet_id: @pet_4.id, application_id: @application_2.id)
    # ApplicationPet.create!(pet_id: @pet_3.id, application_id: @application_1.id)
  end

  describe "As a visitor" do
    describe "when I visit an admin application show page" do
      describe "Approving a Pet for Adoption" do
        it "shows an approve button next to every pet for that application" do
          visit("/admin/applications/#{@application_1.id}")

          expect(page).to have_button("Approve #{@pet_1.name}")
        end
        
        it "directs back to the admin application show page when approve button is clicked" do
          visit("/admin/applications/#{@application_1.id}")
          
          click_button("Approve #{@pet_1.name}")
          
          expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        end
        
        it "no longer has the approve button once that button has been clicked" do
          visit("/admin/applications/#{@application_1.id}")
          
          click_button("Approve #{@pet_1.name}")
          
          expect(page).to_not have_content("Approve #{@pet_1.name}")
        end

        it "shows an indicator next to the pet that says that pet has been approved" do
          visit("/admin/applications/#{@application_1.id}")

          click_button("Approve #{@pet_1.name}")

          expect(page).to have_content("#{@pet_1.name}: Approved")
        end
      end

      describe "Rejecting a Pet for Adoption" do
        it "shows a reject button next to every pet for that application" do
          visit("/admin/applications/#{@application_1.id}")

          expect(page).to have_button("Reject #{@pet_1.name}")
        end
        
        it "directs back to the admin application show page when reject button is clicked" do
          visit("/admin/applications/#{@application_1.id}")
          
          click_button("Reject #{@pet_1.name}")
          
          expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        end
        
        it "no longer has the reject button once that button has been clicked" do
          visit("/admin/applications/#{@application_1.id}")
          
          click_button("Reject #{@pet_1.name}")
          
          expect(page).to_not have_content("Reject #{@pet_1.name}")
        end

        it "shows an indicator next to the pet that says that pet has been rejected" do
          visit("/admin/applications/#{@application_1.id}")

          click_button("Reject #{@pet_1.name}")

          expect(page).to have_content("#{@pet_1.name}: Rejected")
        end
      end
    end
  end
end