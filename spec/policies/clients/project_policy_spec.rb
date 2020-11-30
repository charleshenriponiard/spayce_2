require 'rails_helper'

RSpec.describe Clients::ProjectPolicy do
  subject { Clients::ProjectPolicy }

  before :all do
    @user1 = create(:user, :with_project)
  end

  def resolve_for(user)
    subject::Scope.new(user, Project).resolve
  end

  permissions :show? do
    it "grants access to user who created the project only" do
      expect(subject).to permit(@user1, @user1.projects.first)
    end
  end

  permissions ".scope" do
    it "Should return all project" do
      expect(resolve_for(@user).count).to eq(Project.count)
    end
  end
end
