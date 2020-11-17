class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :canceled, :sending]
  helper_method :sort_column, :sort_direction

  include Pagy::Backend

  def index
    if params["search"]
      @projects = Project.search_by_client_and_name(params["search"])
      @projects = policy_scope(@projects)
    elsif params["sort"]
      @projects = sortable_column_order
      @projects = policy_scope(@projects)
    elsif params["filter"]
      @projects = Project.send("filter_by_#{params["filter"]}") if params["filter"]
      @projects = policy_scope(@projects)
    else
      @projects = policy_scope(Project.all)
    end
    @pagy, @projects = pagy(@projects, items: 10)
    @project_sent = Rails.application.routes.recognize_path(request.referer)[:action] == 'confirmation'
  end

  def show
  end

  def new
    @project = Project.new
    authorize(@project)
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    authorize(@project)
    if @project.save && current_user.verified?
      CreateCheckoutSessionJob.perform_later(@project)
      redirect_to confirmation_project_path(@project)
    else
      render :new
    end
  end

  def canceled
    @project.purge_documents
    @project.canceled!
    redirect_to root_path
  end

  def confirmation
    @project = Project.includes(documents_attachments: :blob).friendly.find_by_slug(params[:slug])
    authorize(@project)
  end

  def sending
    ClientMailer.transfert_project_to_client(@project, params[:slug]).deliver_later
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :message, :client_first_name, :client_last_name, :client_email, :amount, :url, documents: [])
  end

  def set_project
    @project = Project.friendly.find_by_slug(params[:slug])
    authorize(@project)
  end

  def sortable_column_order
    Project.order("#{sort_column} #{sort_direction}")
  end

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : nil
  end

  def sort_column
    authorize_sortable_column.include?(params[:sort]) ? params[:sort] : "client_last_name"
  end

  def authorize_sortable_column
    ["client_last_name", 'amount_cents']
  end
end
