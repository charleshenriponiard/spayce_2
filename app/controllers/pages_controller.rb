class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :account_confirmation ]

  def account_confirmation
  end

  def cookie
  end
end
