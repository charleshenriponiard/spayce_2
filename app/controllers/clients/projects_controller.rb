class Clients::ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  def show
  end

  private

  def set_project
    @project = Project.includes(documents_attachments: :blob).find(params[:id])
    authorize(@project)
  end
end
