require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { ApplicationPolicy }

  permissions :index?, :show?, :new?, :create?, :edit?, :update?, :destroy? do
    it "denies access to any user" do
      expect(subject).not_to permit(User.new, Project.new)
    end
  end
end
