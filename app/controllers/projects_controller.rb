class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :destroy, :edit, :update, :delete_document]


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
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def index
    if params["search"]
      @projects = policy_scope(Project.search_by_client_and_name(params["search"]))
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
    @project = Project.includes(documents_attachments: :blob).find(params[:id])
    authorize(@project)
  end
end
