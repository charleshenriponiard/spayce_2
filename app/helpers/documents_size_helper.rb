module DocumentsSizeHelper
  def document_count_and_size(documents)
    "#{pluralize documents.count, t('views.projects.confirmation.files')} / #{documents_to_mb(documents)} #{t('views.projects.confirmation.mega_bytes')}"
  end

  def documents_to_mb(documents)
    bytes_to_mb(documents.map(&:byte_size).sum)
  end

  def bytes_to_mb(number)
    (number / 1000.0).round(2)
  end
end
