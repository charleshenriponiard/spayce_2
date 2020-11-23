class ExpireProjectJob < ApplicationJob
  queue_as :default

  def perform(project)
    unless project.canceled?
      project.expired!
      project.purge_documents
      # Envoyer un mail
    end
  end
end
