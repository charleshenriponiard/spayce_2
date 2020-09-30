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
      ZipDocumentsJob.perform_later(@project)
      redirect_to project_path(@project)
    else
      render :new
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
    redirect_to project_path(@project)
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :message, :client_first_name, :client_last_name, :client_email, :amount, :url, documents: [])
  end

  def set_project
    @project = Project.find(params[:id])
    authorize(@project)
  end
end
