require 'rails_helper'

RSpec.describe ProjectPolicy do
  subject { ProjectPolicy }

  permissions :new?, :create? do
    it "grants access to any user" do
      expect(subject).to permit(User.new, Project.new)
    end
  end

  permissions :index? do
    it "denies access to any user" do
      expect(subject).not_to permit(User.new, Project.new)
    end
  end

  permissions :show?, :edit?, :update?, :destroy? do
    it "grants access to any user" do
      expect(subject).to permit(User.new, Project.new)
    end
  end
end
