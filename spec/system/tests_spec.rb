require 'rails_helper'

RSpec.describe "Tests", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "is right layout links" do
    visit root_path
    expect(page).to have_current_path(root_path)
    click_link "About"
    expect(page).to have_current_path(about_path)
    click_link "お問い合わせ"
    expect(page).to have_current_path(contact_path)
  end
end