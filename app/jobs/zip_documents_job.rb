class ZipDocumentsJob < ApplicationJob
  queue_as :zip

  def perform(project)
    zipped_key = MultiFileZipperDownload.new(project, ENV["BUCKET"]).call
    url = S3Service.get_download_link(zipped_key, bucket: ENV["BUCKET"])
    project.update(url: url, zipped_key: zipped_key)
    ProjectChannel.broadcast_to(
      project,
      {
        html: ApplicationController.new.render_to_string(partial: 'clients/projects/button', locals: { project: project })
      }
    )
  end
end
