class ZipService
  BUCKET = ENV["BUCKET"]

  def initialize(documents)
    @documents = documents
  end

  def save_files_on_server
  # get a temporary folder and create it
  temp_folder = File.join(Dir.tmpdir, 'user')
  FileUtils.mkdir_p(temp_folder) unless Dir.exist?(temp_folder)

  # download all ActiveStorage into
  @documents.map do |picture|
    filename = picture.filename.to_s
    filepath = File.join temp_folder, filename
    File.open(filepath, 'wb') { |f| f.write(picture.download) }
    filepath
  end

  def create_temporary_zip_file(filepaths)
    require 'zip'
    temp_file = Tempfile.new('user.zip')

    begin
      # Initialize the temp file as a zip file
      Zip::OutputStream.open(temp_file) { |zos| }

      # open the zip
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|
        filepaths.each do |filepath|
          filename = File.basename filepath
          # add file into the zip
          zip.add filename, filepath
        end
      end

      return File.read(temp_file.path)
    ensure
      # close all ressources & remove temporary files
      temp_file.close
      temp_file.unlink
      filepaths.each { |filepath| FileUtils.rm(filepath) }
    end
  end
end
