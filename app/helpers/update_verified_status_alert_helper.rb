module UpdateVerifiedStatusAlertHelper
  def update_verified_status_alert(user)
    user.verified_status_alert = false
    user.save
  end
end
