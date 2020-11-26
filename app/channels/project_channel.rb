class ProjectChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @project = Project.find(params[:id])
    stream_for @project
  end
end
