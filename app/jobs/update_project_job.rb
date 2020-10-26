class UpdateProjectJob < ApplicationJob
  queue_as :stripe

  def perform(project, hash)
    project.update(hash)
  end
end
