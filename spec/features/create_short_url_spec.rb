require 'spec_helper'

describe "creating a short url" do
  context "when not signed in" do

    it "lets me get a new short url" do 
      visit dashboard_path 

      fill_in "link_long_url", with: "http://cnn.com"
      click_button "Shorten It!"
      expect(page).to have_content "http://cnn.com"
      expect(page).to have_content "links to"

    end 

    it "does not let me enter an invalid url" do 
      visit dashboard_path 

      fill_in "link_long_url", with: "hbiob"
      click_button "Shorten It!"

      expect(page).to have_content "MAKE YOUR LINKS COUNT!"
    end 

  end

  context "when signed in" do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    it "lets me get a new short url" do 
      visit dashboard_path 

      fill_in "link_long_url", with: "http://cnn.com"
      click_button "Shorten It!"

      expect(page).to have_content "links to"
      expect(page).to have_content "http://cnn.com"
    end 

    it "does not let me enter an invalid url" do 
      visit dashboard_path

      fill_in "link_long_url", with: "hbiob"
      click_button "Shorten It!"

      expect(page).to have_content "MAKE YOUR LINKS COUNT!"
    end 

  end
end
