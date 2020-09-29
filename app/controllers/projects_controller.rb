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
      @filepaths = @project.documents.map do |key|
        new_path = "#{@dir}/#{key.split('/').last}" # Keep the filename but avoid the fill path
        # This should go in a separate service
        Aws::S3::Resource.new.bucket(@bucket).object(key).download_file(new_path)
        new_path
        byebug
      end
      # Zip::File.open('Archive.zip', Zip::File::CREATE) do |zipfile|
      #   @project.documents.each do |document|
      #     zipfile.add(document, document)
      #   end
      # end
      # @zip_document = ZipService.new(@project.documents)
      # @zip_document.save_files_on_server
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
