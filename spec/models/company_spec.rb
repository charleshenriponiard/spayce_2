require 'rails_helper'

RSpec.describe Company, type: :model do
  before(:all) do
    @company1 = create(:company)
  end

  it "is valid with valid attributes" do
    expect(@company1).to be_valid
  end
end

