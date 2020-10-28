class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :destroy, :edit, :update, :delete_document]
  helper_method :sort_column, :sort_direction

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
    if @project.save
      CreateCheckoutSessionJob.perform_later(@project)
      redirect_to project_path(@project)
    else
      render :new
    end
  end

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
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.purge_documents
    @project.delete
    redirect_to root_path
  end

  def delete_document
    @document = ActiveStorage::Attachment.find(params[:document_id])
    @document.purge
    authorize @document, policy_class: ProjectPolicy
    ZipDocumentsJob.perform_later(@project)
    @project.update(documents_count: @project.documents.attachments.count)
    redirect_to project_path(@project)
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
    ["client_last_name", 'amount']
  end
end
