require "rails_helper"
require 'digest'

RSpec.describe MultiFileZipperDownload do
  let(:user) { create(:user, :with_project) }
  let(:project) { user.projects.last }
  let(:object) { MultiFileZipperDownload.new(project, ENV["BUCKET"]) }

  describe "#initializer" do
    it "new instance" do
      expect(object.instance_variable_names).to eq(["@project", "@bucket", "@zipped_file_name"])
    end
  end

  describe "#name_zip" do
    it "downcase and join with '_'" do
      project.name = "Test    Name zip"
      expect(object.send(:name_zip)).to eq("test_name_zip")
    end
  end

  describe "#tmp_dir" do
    it "create new folder before download file" do
      expect(object.send(:tmp_dir)).to be_a(String)
    end
  end

  describe "#zipped_file_path" do
    it "should return the correct path" do
      tmp_dir = object.send(:tmp_dir)
      name_zip = object.send(:name_zip)
      expect(object.send(:zipped_file_path)).to eq("#{tmp_dir}/#{name_zip}")
    end
  end

  describe "#build_zipped_s3_key" do
    it "Create a new key" do
      hash = Digest::SHA256.file('spec/fixtures/test_file.rb').to_s
      expect(hash).to be_a(String)
    end
  end

  describe "#save_file" do
    it "attach new doc on project" do
      project.documents.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test.png')), filename: 'test.png', content_type: 'image/png')
      doc = project.documents.first.blob
      new_path = "#{object.send(:tmp_dir)}/#{doc.filename}"
      expect(new_path.split("/").last).to eq("test.png")
    end
  end

  describe "#call" do
    it "should return a path who start by multi_downloads and should have the right number of elements" do
      path = object.call
      expect(path.split("/").first).to eql("multi_downloads")
      expect(path.split("/").count).to eql(3)
    end
  end
end
