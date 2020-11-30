require 'zip'

class MultiFileZipperDownload

  def initialize(project, bucket)
    @project = project
    @bucket = bucket
    @zipped_file_name = name_zip
  end

  def call
    zip_files(save_file_local)
    build_zipped_s3_key
    upload_zip
    delete_tmp_file
    @zipped_s3_key
  end

  private

  def save_file_local
    @filepaths = @project.documents.blobs.map do |doc|
      new_path = "#{tmp_dir}/#{doc.filename}"
      Aws::S3::Bucket.new(ENV["BUCKET"]).object(doc.key).download_file(new_path)
      new_path
    end
  end

  def zip_files(files)
    Zip::File.open(zipped_file_path, Zip::File::CREATE) do |zipfile|
      files.each do |filepath|
        zipfile.add(filepath.split('/').last, filepath)
      end
    end
  end

  def tmp_dir
    @tmp_dir ||= Dir.mktmpdir
  end

  def zipped_file_path
    "#{tmp_dir}/#{@zipped_file_name}"
  end

  def build_zipped_s3_key
    # I use the hash of the file to avoid collisions, but you can change this to whatever you like
    hash = Digest::SHA256.file(zipped_file_path).to_s
    @zipped_s3_key = "multi_downloads/#{hash}/#{@zipped_file_name}"
  end

  def upload_zip
    # I upload the zipped file to S3 so we can send a link to tje file afterwards
    S3Service.upload_file(from: zipped_file_path, to: @zipped_s3_key, bucket: @bucket)
  end

  def delete_tmp_file
    # Remove all the files to avoid disk usage leaks
    FileUtils.rm_rf(tmp_dir)
  end

  def name_zip
    @project.name.split.map(&:downcase).join("_")
  end
end
