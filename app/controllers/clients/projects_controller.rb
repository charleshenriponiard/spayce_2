class Clients::ProjectsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :create_checkout_session]
  before_action :set_project, only: [:show, :create_checkout_session]

  def show; end

  def create_checkout_session
    ::Stripe::CheckoutSessionCreator.call(@project)
    render json: {
      sucess: true,
      data: @project
    }, status: 200
  end

  private

  def set_project
    @project = Project.includes(documents_attachments: :blob).friendly.find_by_slug(params[:slug])
    authorize @project, policy_class: Clients::ProjectPolicy
  end
end
