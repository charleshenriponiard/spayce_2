class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable, :recoverable, :confirmable,
  :rememberable, :validatable
  has_one :company, dependent: :destroy
  has_many :projects, dependent: :destroy

  enum verification_status: { no_account: 0, onboarded: 1, information_needed: 2, verified: 3 }
end
