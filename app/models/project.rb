class Project < ApplicationRecord
  include PgSearch::Model

  after_save :paid, if: :saved_change_to_payment_status?

  belongs_to :user
  has_many_attached :documents
  has_one :invoice

  monetize :amount_cents

  extend FriendlyId
  friendly_id :random_slug, use: :slugged


  after_destroy do
    purge_documents
  end

  pg_search_scope :search_by_client_and_name,
    against: [ :client_last_name, :client_first_name, :name  ],
    using: {
      trigram: {
        threshold: 0.1
      }
    }

  enum status: { sent: 0, paid: 1, canceled: 2, expired: 3 }
  enum payment_status: { payment_failed: 0, payment_succeeded: 1 }

  scope :filter_by_sent, ->  { where status: "sent" }
  scope :filter_by_paid, ->  { where status: "paid" }
  scope :filter_by_canceled, ->  { where status: "canceled" }
  scope :filter_by_expired, ->  { where status: "expired" }
  scope :filter_by_canceled_or_expired, -> { filter_by_canceled.or(filter_by_expired) }

  WATERMARK_PATH = Rails.root.join('lib', 'assets', 'images', 'watermark.png')

  # validate :acceptable_documents

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

  def purge_documents
    self.documents.each{ |document| document.purge_later}
  end

  def tax
    commission * 0.20
  end

  def commission
    amount * 0.10 * (1 - discount)
  end

  def total
    amount - commission - tax
  end

  private

  def paid
    if self.payment_succeeded?
      ClientMailer.payment_validation(self).deliver_later
      UserMailer.accepted_payment(self).deliver_later
    end
  end

  def random_slug
    maj = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
    min = "abcdefghijklmnopqrstuvwxyz".split('')
    num = "1234567890".split('')
    spe = "&\"'(§],?;.:/=+-_)({}[!*$¨^%£`<>".split('')

    random = [maj.sample, maj.sample, min.sample, maj.sample, min.sample, min.sample, num.sample, num.sample, spe.sample, num.sample, spe.sample, spe.sample].shuffle.join('')
    return random
  end
end
