require 'rails_helper'

RSpec.describe "static_pages/home.html.erb", type: :view do
  describe "GET /home" do
    it "h1 has SapleApp" do
      expect(page).to have_selector("h1", text: "Sample APP")
    end
  end
end
