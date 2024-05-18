require "rails_helper"

RSpec.describe "Application New Page" do
  describe "as a visitor" do
    it "shows a form with fields for name, address, description" do
      visit("/applications/new")

      expect(page).to have_field("Name")
      expect(page).to have_field("Street address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Description")
    end

    it "can create an application when form is submitted" do
      visit("/applications/new")

      fill_in(:name, with: "Jimmy")
      fill_in(:street_address, with: "123 Rome Ave")
      fill_in(:city, with: "Minneapolis")
      fill_in(:state, with: "MN")
      fill_in(:zip, with: "45678")
      fill_in(:description, with: "I'm the best dog owner of all time")

      click_button("Save")

      
      # expect(current_path).to eq("/applications/#{Application.count}")

      expect(page).to have_content("Jimmy")
      expect(page).to have_content("123 Rome Ave")
      expect(page).to have_content("Minneapolis")
      expect(page).to have_content("MN")
      expect(page).to have_content("45678")
      expect(page).to have_content("I'm the best dog owner of all time")
    end
  end
end