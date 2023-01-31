require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'root' do
    it 'root_pathへのリンク、help, about, contactへのリンクが表示されていること' do
      visit root_path
      link_to_root = page.find_all("a[href=\"#{root_path}\"]")

      expect(link_to_root.size).to eq 1
      expect(page).to have_link 'About', href: about_path
      expect(page).to have_link "お問い合わせ", href: contact_path
    end
  end

  describe "home" do
    it "display correct following and followers" do
      user = FactoryBot.send(:create_relationships)
      sign_in(user)
      visit root_path
      expect(page).to have_content "10 following"
      expect(page).to have_content "10 followers"

      visit user_path(user)
      expect(page).to have_content "10 following"
      expect(page).to have_content "10 followers"
    end
  end
end
