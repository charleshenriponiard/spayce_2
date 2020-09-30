class ProjectsController < ApplicationController
require 'aws-sdk-s3'
require 'zip'
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
      # @zip_file = ZipService.new(@project.documents)
      # @zip_file.save_file_local
      # @zip_file.create_zip
      # @zip_file.download_link_zip

      zipped_key = MultiFileZipperDownload.new(@project.documents, ENV["BUCKET"]).call
      url = S3Service.get_download_link(zipped_key, bucket: ENV["BUCKET"])
      byebug
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
