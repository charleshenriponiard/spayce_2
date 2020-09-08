require 'rails_helper'

RSpec.describe User, type: :model do

  before(:all) do
    @user1 = create(:user)
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    user2 = build(:user, email: "test@gmail.com")
    expect(user2).to_not be_valid
  end

  it "is not valid without a password" do
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without an email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end

  it "should permit to update all the added fields" do
    @user1.update(
      uid: "test",
      provider: "test",
      access_code: "test",
      publishable_key: "test",
      country: "test",
      phone_number: "test",
      first_name: "test",
      last_name: "test",
      admin: true
    )
    expect(@user1).to be_valid
  end
end

