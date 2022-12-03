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

  it "accepts valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user = FactoryBot.build(:user, email: valid_address)
      expect(user).to be_valid
    end
  end

  it "rejects valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org foo@bar_baz.com
                           user.name@example. foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user = FactoryBot.build(:user, email: invalid_address)
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
  end

  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user)
    user = FactoryBot.build(:user)
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is saved as lowcase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user = FactoryBot.build(:user, email: mixed_case_email)
    user.save
    expect(mixed_case_email.downcase).to eq user.reload.email
  end

  it "is present (nonblank)" do
    user = FactoryBot.build(:user)
    user.password = user.password_confirmation = " " * 6
    expect expect(user).to_not be_valid
  end

  it "has a minimum length" do
    user = FactoryBot.build(:user)
    user.password = user.password_confirmation = "a" * 5
    expect expect(user).to_not be_valid
  end
end
