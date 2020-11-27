require 'rails_helper'

RSpec.describe User, type: :model do

  before(:all) do
    @user1 = create(:user, email: "test@gmail.com")
    @user2 = build(:user, email: "test@gmail.com")
    @user3 = build(:user, password: nil)
    @user4 = build(:user, email: nil)
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique email" do
    expect(@user2).to_not be_valid
  end

  it "is not valid without a password" do
    expect(@user3).to_not be_valid
  end

  it "is not valid without an email" do
    expect(@user4).to_not be_valid
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
      siret: "test",
      entity_name: "test",
      address_line1: "test",
      city: "test",
      state: "test",
      admin: true
    )
    expect(@user1).to be_valid
  end
end

