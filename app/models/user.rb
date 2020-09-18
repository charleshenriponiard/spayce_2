class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :async, :registerable, :recoverable, :confirmable,
  :rememberable, :validatable, :omniauthable#, omniauth_providers: [:stripe_connect]
  has_one :company, dependent: :destroy

  def can_receive_payments?
    uid? &&  provider? && access_code? && publishable_key?
  end

  def completed_onboarding?
    if self.uid?
      stripe = Stripe::Express.new
      answer = stripe.find_account(uid)
      answer["details_submitted"]
    else
      false
    end
  end
end
