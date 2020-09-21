class UpdateUserJob < ApplicationJob
  queue_as :default

  def perform(user, hash)
    user.update(hash)
  end
end
