require "rails_helper"

RSpec.describe "New Application Page" do
  describe "as a visitor" do
    describe "when I visit the new application page" do
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

        click_button("Submit")

        
        # expect(current_path).to eq("/applications/#{Application.count}")

        expect(page).to have_content("Jimmy")
        expect(page).to have_content("123 Rome Ave")
        expect(page).to have_content("Minneapolis")
        expect(page).to have_content("MN")
        expect(page).to have_content("45678")
        expect(page).to have_content("I'm the best dog owner of all time")
      end

      describe "Sad Path" do
        describe "when any of the form fields have not been filled in and submit button is clicked" do
          it "directs back to the new application page" do
            visit("/applications/new")

            fill_in(:name, with: "Jimmy")
            fill_in(:street_address, with: "123 Rome Ave")
            fill_in(:city, with: "Minneapolis")
            fill_in(:state, with: "MN")
            fill_in(:zip, with: "45678")
            #description missing

            click_button("Submit")

            expect(current_path).to eq("/applications/new")
          end

          it "displays a message saying that all form fields must be filled in" do
            visit("/applications/new")

            # name missing
            fill_in(:street_address, with: "123 Rome Ave")
            fill_in(:city, with: "Minneapolis")
            fill_in(:state, with: "MN")
            fill_in(:zip, with: "45678")
            fill_in(:description, with: "I'm the best dog owner of all time.")

            click_button("Submit")

            expect(page).to have_content("Please fill in answers to all prompts")

            # will still create new application if street address, city, state, zip are missing
          end
        end
      end
    end
  end
end