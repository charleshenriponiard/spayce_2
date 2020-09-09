class CreateCompanyJob < ApplicationJob
  queue_as :default

  def perform(user)
    @user = user
    Stripe.api_key = ENV["STRIPE_PRIVATE_KEY"]
    stripe_account = Stripe::Account.retrieve(@user.uid)
    object = format_hash(stripe_account)
    company = Company.new(object)
    company.user = @user
    company.save
  end

  private

  def format_hash(account)
    company_profile = account["business_profile"]
    # address = account["company"]["address"] || nil

    return {
      # mcc: company_profile["mcc"],
      name: company_profile["name"],
      # business_type: account["business_type"],
      # address_line1: address["line1"],
      # address_line2: address["line2"],
      # city: address["city"],
      # country: address["country"],
      # postal_code: address["postal_code"],
      # state: address["state"],
      phone_number: company_profile["support_phone"]
    }
  end
end
