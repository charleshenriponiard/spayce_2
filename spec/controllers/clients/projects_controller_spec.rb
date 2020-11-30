require 'rails_helper'

RSpec.describe Clients::ProjectsController, type: :controller do
  let(:user) { create(:user, :with_project) }
  let(:project) { user.projects.last }

  describe "#show" do
    it "should render show view" do
      get :show, params: { slug: project.slug}
      assert_template :show
    end
  end
end
