class Clients::ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  def show
  end

  private

  def set_project
    @project = Project.includes(documents_attachments: :blob).friendly.find_by_slug(params[:slug])
    authorize(@project)
  end
end
