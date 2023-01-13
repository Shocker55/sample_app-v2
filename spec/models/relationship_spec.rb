require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:other) { FactoryBot.create(:archer) }
  let(:relationship) { Relationship.new(follower_id: user.id,
                                          followed_id: other.id) }

  it "is valid" do
    expect(relationship).to be_valid
  end

  it "requires a follower_id" do
    relationship.follower_id = nil
    expect(relationship).to be_invalid
  end

  it "requires a followed_id" do
    relationship.followed_id = nil
    expect(relationship).to be_invalid
  end
end
