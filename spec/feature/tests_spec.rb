require 'rails_helper'

RSpec.describe "Tests", type: :feature do
  it "is right layout links" do
    visit root_path
    click_link "About"
    expect(page).to have_selector("h1", text: "About")
    click_link "お問い合わせ"
    expect(page).to have_selector("h1", text: "Contact")
  end
end
