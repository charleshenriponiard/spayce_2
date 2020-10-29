require 'rails_helper'
require_relative "../support/devise"

RSpec.describe ProjectsController, type: :controller do
  before(:each) do
    @user = create(:user)
  end

  describe "#new" do
    login_user
    it "Should return an Project instance" do
      expect(@user.projects.new).to be_kind_of(Project)
    end

    it "@project should contain a user.id of the current_user" do
      @project = @user.projects.new
      expect(@project.user.id).to eql(@user.id)
    end
  end

  describe "#create" do
    login_user
    it "Should have an id" do
      project = @user.projects.create!(name: "test", amount_cents: 100000)
      expect(Project.last.id).to eql(project.id)
    end
    it "Should have +1 project" do
      count = @user.projects.length
      @user.projects.create!(amount_cents: 100000)
      expect(@user.projects.length).to eql(count + 1)
    end
  end
end
