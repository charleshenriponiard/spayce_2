class Project < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many_attached :documents

  after_commit do
    if nbr_documents
      ZipDocumentsJob.perform_later(self)
      self.update(documents_count: self.documents.attachments.count)
    end
  end
  pg_search_scope :search_by_client_and_name,
    against: [ :client_last_name, :client_first_name, :name  ],
    using: {
              trigram: {
                threshold: 0.1
              }
            }

  enum status: { draft: 0, sent: 1, paid: 2, canceled: 3, expired: 4 }

  scope :filter_by_sent, ->  { where status: "sent" }
  scope :filter_by_paid, ->  { where status: "paid" }
  scope :filter_by_canceled, ->  { where status: "canceled" }
  scope :filter_by_expired, ->  { where status: "expired" }
  # validate :acceptable_documents

  WATERMARK_PATH = Rails.root.join('lib', 'assets', 'images', 'watermark.png')

  # def acceptable_documents
  #   documents.each do |document|
  #     return unless document.attached?

  #     unless document.byte_size <= 1.megabyte
  #       errors.add(:document, "le fichier est trop volumineux")
  #     end

  #     acceptable_types = ["image/jpeg", "image/png"]
  #     unless acceptable_types.include?(main_image.content_type)
  #       errors.add(:main_image, "must be a JPEG or PNG")
  #     end
  #   end
  # end

  def nbr_documents
    self.documents_count != self.documents.attachments.count
  end
end
