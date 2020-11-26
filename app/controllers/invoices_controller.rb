class InvoicesController < ApplicationController

  skip_before_action :authenticate_user!, only: :show
  layout "invoice"

  def show
    @project = Project.find_by(slug: params[:project_slug])
    authorize @project, policy_class: InvoicePolicy
  end
end
