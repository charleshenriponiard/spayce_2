module S3Service
  class << self
    def upload_file(from:, to:, bucket:)
      object = object(to, bucket: bucket)
      object.upload_file(from)
      object.presigned_url(:get)
    end

    def download_file(key:, to:, bucket:)
      object = object(key, bucket: bucket)
      object.download_file(to)
    end

    def delete_object(key:, bucket:)
      bucket(bucket).delete_objects({
        delete: { # required
          objects: [ # required
            {
              key: key # required
            },
          ],
        },
      })
    end

    def get_download_link(file_name, bucket:)
      object(file_name, bucket: bucket).presigned_url(:get).to_s
    end

    private

    def object(file_name, bucket:)
      bucket(bucket).object(file_name)
    end

    def bucket(bucket)
      Aws::S3::Resource.new.bucket(bucket)
    end
  end
end
