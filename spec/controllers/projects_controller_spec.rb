require 'rails_helper'
require_relative "../support/devise"

RSpec.describe ProjectsController, type: :controller do
  describe "GET projects#index" do
    login_user
    it "assigns @projects with current_user projects if no params" do
      project1, project2 = create(:project, user: @user), create(:project, user: @user)
      get :index
      expect(assigns(:projects)).to match_array([project1, project2])
    end

    it "assigns @projects filtered with params search" do
      project1, project2 = create(:project, user: @user, name: "Projet photo"), create(:project, user: @user)
      get :index, params: { search: "photo" }
      expect(assigns(:projects)).to match_array([project1])
    end

    it "assigns @projects filtered with params filter" do
      project1, project2 = create(:project, user: @user, name: "Projet photo", status: 'paid_expired'), create(:project, user: @user)
      get :index, params: { filter: "paid_expired" }
      expect(assigns(:projects)).to match_array([project1])
    end

    it "assigns @projects sorted with params sort and direction" do
      project1, project2 = create(:project, user: @user, name: "Projet photo", status: 'paid_expired', amount_cents: 10000), create(:project, user: @user, amount_cents: 5000)
      sorted_array = [project1, project2].sort_by(&:amount_cents)
      get :index, params: { sort: "amount_cents", direction: "asc" }
      expect(assigns(:projects)).to match_array(sorted_array)
    end

    it "renders the index template" do
      get :index
      assert_template :index
    end
  end

  describe "GET projects#show" do
    login_user
    it "assigns @projects with current_user projects if no params" do
      project = create(:project, user: @user)
      get :show, params: { slug: project.slug }
      expect(assigns(:project)).to eq(project)
    end

    it "renders the show template" do
      project = create(:project, user: @user)
      get :show, params: { slug: project.slug }
      assert_template :show
    end
  end

  describe "GET projects#new" do
    login_user
    it "Should return an Project instance" do
      expect(@user.projects.new).to be_kind_of(Project)
    end

    it "renders the new template" do
      project = Project.new
      get :new
      assert_template :new
    end
  end

  describe "POST projects#create" do
    login_user
    it "Should create a project" do
      @user.update(verification_status: 3, uid: "acct_1Hr2QtRLEyCi9Muf")
      expect {
        VCR.use_cassette 'stripe_checkout_session' do
          post :create, params: { project: { amount: 1000, name: 'A great Project', client_last_name: 'Michel Durand', client_email: 'michel.durand@gmail.com' } }
        end
      }.to change(Project, :count).by(1)
    end

    it "Should redirect to confirmation" do
      @user.update(verification_status: 3, uid: "acct_1Hr2QtRLEyCi9Muf")
      VCR.use_cassette 'stripe_checkout_session' do
        post :create, params: { project: { amount: 1000, name: 'A great Project', client_last_name: 'Michel Durand', client_email: 'michel.durand@gmail.com' } }
      end
      expect(response).to redirect_to(confirmation_project_path(Project.last))
    end

    it "renders the new template if project isn't valid" do
      @user.update(verification_status: 3, uid: "acct_1Hr2QtRLEyCi9Muf")
      post :create, params: { project: { name: '' } }
      assert_template :new
    end
  end

  # describe "GET projects#promo_code" do
  #   login_user
  #   # it "Should create a project" do
  #   #   post :create, params: { project: { amount_cents: 100000, name: 'A great Project', client_last_name: 'Michel Durand', client_email: 'michel.durand@gmail.com' } }
  #   #   expect(response).to redirect_to(confirmation_project_path(slug: Project.last.slug))
  #   # end

  #   # it "Should redirect to confirmation" do
  #   #   post :create, params: { project: { amount_cents: 100000, name: 'A great Project', client_last_name: 'Michel Durand', client_email: 'michel.durand@gmail.com' } }
  #   #   expect(response).to redirect_to(confirmation_project_path(slug: Project.last.slug))
  #   # end

  #   # it "renders the new template if project isn't valid" do
  #   #   post :create, params: { project: { name: 'A great Project', client_last_name: 'Michel Durand', client_email: 'michel.durand@gmail.com' } }
  #   #   assert_template :new
  #   # end
  # end
end
