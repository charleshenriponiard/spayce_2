class ZipDocumentsJob < ApplicationJob
  queue_as :zip

  def perform(project)
    zipped_key = MultiFileZipperDownload.new(project, ENV["BUCKET"]).call
    url = S3Service.get_download_link(zipped_key, bucket: ENV["BUCKET"])
    project.update(url: url)
  end
end
