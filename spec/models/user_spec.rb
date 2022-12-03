require 'rails_helper'

RSpec.describe User, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid with too long name" do
    user = User.new(name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end

  it "is invalid with too long email" do
    user = User.new(email: "a" * 244 + "@example.com")
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  # it "email validation should accept valid addresses" do
  #   valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
  #                        first.last@foo.jp alice+bob@baz.cn]
  #   valid_addresses.each do |valid_address|
  #     user = User.new(email: "#{valid_address}")
  #     user.valid?
  #     expect  "#{valid_address.inspect} should be valid"
  # end

end
