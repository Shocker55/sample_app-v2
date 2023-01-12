require 'rails_helper'

RSpec.describe "StaticPages", type: :system do

  describe "home" do
    it "display correct following and followers" do
      user = FactoryBot.send(:create_relationships)
      log_in_as user
      expect(page).to have_content "10 following"
      expect(page).to have_content "10 followers"

      visit user_path(user)
      expect(page).to have_content "10 following"
      expect(page).to have_content "10 followers"
    end
  end
end
