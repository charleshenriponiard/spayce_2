require 'rails_helper'
require_relative "../support/devise"

RSpec.describe InvoicesController, type: :controller do
  let(:user) { create(:user, :with_project) }
  let(:project) { user.projects.last }
  let(:invoice) { Invoice.create(project: project) }

  describe "#show" do
    it "test invoice view" do
      get :show, params: { project_slug: project.slug, id: invoice.id }
      assert_template :show
    end

    it "should return the correct layout" do
      get :show, params: { project_slug: project.slug, id: invoice.id }
      expect(subject).to render_template("layouts/invoice")
    end
  end
end
