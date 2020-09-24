require 'rails_helper'
require_relative "../support/devise"

RSpec.describe RegistrationsController, type: :controller do
  before(:each) do
    @user = create(:user)
  end

  controller do
    def after_sign_up_path_for(resource)
      super resource
    end

    def after_update_path_for(resource)
      super resource
    end
  end

  describe "#after_sign_up_path_for" do
    login_user
    it "redirects to the user_root_path" do
      expect(controller.after_sign_up_path_for(@user)).to eql(registration_steps_path)
    end
  end

  describe "#after_update_path_for" do
    login_user
    it "redirects to the root_path" do
      expect(controller.after_update_path_for(@user)).to eql(root_path)
    end
  end
end
