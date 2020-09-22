class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable, :recoverable, :confirmable,
  :rememberable, :validatable
  has_one :company, dependent: :destroy

  enum verification_status: { unvalidated: 0, pending: 1, validated: 2 }
end
