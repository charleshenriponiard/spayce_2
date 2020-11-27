class UpdateProjectJob < ApplicationJob
  queue_as :stripe

  def perform(project, hash)
    project.update(hash)
    Invoice.create(project: project) if project.payment_succeeded?
  end
end
