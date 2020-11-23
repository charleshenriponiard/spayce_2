class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :account_confirmation ]

  def home
  end

  def account_confirmation
  end
end
