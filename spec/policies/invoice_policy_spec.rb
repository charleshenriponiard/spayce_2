require 'rails_helper'

RSpec.describe InvoicePolicy do
  subject { InvoicePolicy }

  let(:user) { create(:user) }

  permissions :show? do
    it "grants access to all user" do
      expect(subject).to permit(user)
      user2 = build(:user)
      expect(subject).to permit(user2)
    end
  end
end
