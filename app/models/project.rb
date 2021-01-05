class Project < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  has_many_attached :documents
  has_one :invoice, dependent: :destroy
  monetize :amount_cents

  validates :amount_cents, presence: true
  validates :name, presence: true
  validates :client_email, presence: true
  validates :client_last_name, presence: true

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
  scope :will_expiry, lambda {
    date = Date.today.prev_day(6)
    Project.filter_by_sent.where(created_at: date.midnight..date.end_of_day)
  }
  scope :expired, lambda {
    date = Date.today.prev_day(7)
    Project.filter_by_sent.where(created_at: date.midnight..date.end_of_day)
  }


  WATERMARK_PATH = Rails.root.join('lib', 'assets', 'images', 'watermark.png')

  def purge_documents
    self.documents.each{ |document| document.purge_later}
  end

  def tax
    commission * 0.20
  end

  def commission
    amount * 0.05 * (1 - discount)
  end

  def total
    amount - commission - tax
  end

  private

  def random_slug
    maj = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')
    min = "abcdefghijklmnopqrstuvwxyz".split('')
    num = "1234567890".split('')
    spe = "&\"'(§],?;.:/=+-_)({}[!*$¨^%£`<>".split('')

    random = [maj.sample, maj.sample, min.sample, maj.sample, min.sample, min.sample, num.sample, num.sample, spe.sample, num.sample, spe.sample, spe.sample].shuffle.join('')
    return random
  end
end
