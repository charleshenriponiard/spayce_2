class ExpireProjectJob < ApplicationJob
  queue_as :default

  def perform(project)
    unless project.canceled?
      project.paid? ? project.paid_expired! : project.unpaid_expired!
      project.purge_documents
      S3Service.delete_object(key: project.zipped_key, bucket: ENV["BUCKET"])
      # Envoyer un mail
    end
  end
end
