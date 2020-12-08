module DocumentPreviewsHelper
  def get_placeholder(blob)
    extension = blob.filename.to_s.split('.').last
    general_type = blob.content_type.to_s.split('/').first
    formats = {
      "prproj" => "video",
      "pdf" => "pdf",
      "xlsx" => "excel",
      "xlsm" => "excel",
      "xls" => "excel",
      "xml" => "excel",
      "csv" => "excel",
      "ods" => "excel",
      "doc" => "word",
      "docm" => "word",
      "docx" => "word",
      "dot" => "word",
      "dotm" => "word",
      "dotx" => "word",
      "odt" => "word",
      "tiff" => "tiff",
      "ai" => "illustrator",
      "psd" => "photoshop",
      "mp4" => "video",
      "ppt" => "ppt",
      "odp" => "ppt",
      "pptx" => "ppt",
      "video" => "video",
      "image" => "image"
    }
    return "documents_placeholders/logo-#{formats[extension] || formats[general_type] || 'default'}.png"
  end
end
