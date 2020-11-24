class Project < ApplicationRecord
  include PgSearch::Model

  after_save :paid, if: :saved_change_to_payment_status?

  belongs_to :user
  has_many_attached :documents

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

  enum status: { sent: 0, paid: 1, canceled: 2, paid_expired: 3, unpaid_expired: 4 }
  enum payment_status: { payment_failed: 0, payment_succeeded: 1 }

  scope :filter_by_sent, ->  { where status: "sent" }
  scope :filter_by_paid, ->  { where status: "paid" }
  scope :filter_by_canceled, ->  { where status: "canceled" }
  scope :filter_by_paid_expired, ->  { where status: "paid_expired" }
  scope :filter_by_unpaid_expired, ->  { where status: "unpaid_expired" }
  scope :filter_by_canceled_or_unpaid_expired, -> { filter_by_canceled.or(filter_by_unpaid_expired) }
  scope :filter_by_paid_or_paid_expired, -> { filter_by_paid.or(filter_by_paid_expired) }

  WATERMARK_PATH = Rails.root.join('lib', 'assets', 'images', 'watermark.png')

  def purge_documents
    self.documents.each{ |document| document.purge_later}
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
