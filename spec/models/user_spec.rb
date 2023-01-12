require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without a name" do
    user.name = ""
    expect(user).to_not be_valid
  end

  it "is invalid without an email" do
    user.email = ""
    expect(user).to_not be_valid
  end

  it "is invalid with too long name" do
    user.name = "a" * 51
    expect(user).to_not be_valid
  end

  it "is invalid with too long email" do
    user.email = "#{'a' * 244}@example.com"
    expect(user).to_not be_valid
  end

  it "accepts valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it "rejects valid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org foo@bar_baz.com
                           user.name@example. foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
  end

  it "is invalid with a duplicate email address" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user).to_not be_valid
  end

  it "is saved as lowcase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq mixed_case_email.downcase
  end

  it "is present (nonblank)" do
    user.password = user.password_confirmation = " " * 6
    expect expect(user).to_not be_valid
  end

  it "has a minimum length" do
    user.password = user.password_confirmation = "a" * 5
    expect expect(user).to_not be_valid
  end

  describe "#authenticated?" do
    it "returns false if the digest is nil" do
      expect(user.authenticated?("")).to be_falsy
    end
  end

  describe "#follow and #unfollow" do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:archer) }

    it "turns true when follow a user" do
      expect(user.following?(other)).to_not be_truthy
      user.follow(other)
      expect(user.following?(other)).to be_truthy
    end

    it "turns false when unfollow a user" do
      user.follow(other)
      expect(user.following?(other)).to_not be_falsey
      user.unfollow(other)
      expect(user.following?(other)).to be_falsey
    end
  end
end
