require 'rails_helper'

RSpec.describe ProjectPolicy do
  subject { ProjectPolicy }

  def resolve_for(user)
    subject::Scope.new(user, Project).resolve
  end

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

  permissions ".scope" do
    it "Should return the same number of projects I have" do
      user = create(:user, email: "test@gmail.com")
      expect(resolve_for(user).count).to eq(user.projects.count)
    end
  end
end
