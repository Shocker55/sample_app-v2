require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :view do
  describe "valified title" do
    it "returns correct title" do
      visit home_path
      expect(page).to have_selector("h1", text: "My Favorite Plants")
    end
  end
end
