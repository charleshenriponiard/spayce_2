require 'rails_helper'

RSpec.describe ProjectPolicy do
  subject { ProjectPolicy }

  before :all do
    @user1 = create(:user, :with_project)
  end

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

  permissions :show? do
    it "grants access to user who created the project only" do
      expect(subject).to permit(@user1, @user1.projects.first)
    end
    it "don't grants access to any user " do
      expect(subject).not_to permit(@user1, Project.new)
    end
  end

  permissions ".scope" do
    it "Should return the same number of projects I have" do
      expect(resolve_for(@user1).count).to eq(@user1.projects.count)
    end
  end
end
