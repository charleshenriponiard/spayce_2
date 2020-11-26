class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable, :recoverable, :confirmable,
  :rememberable, :validatable
  has_one :company, dependent: :destroy
  has_many :projects, dependent: :destroy

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :entity_name, presence: true, on: :update
  validates :siret, presence: true, on: :update
  validates :address_line1, presence: true, on: :update
  validates :city, presence: true, on: :update
  validates :state, presence: true, on: :update

  validates :country, presence: true, on: :update

  enum verification_status: { no_account: 0, onboarded: 1, information_needed: 2, verified: 3 }
end
