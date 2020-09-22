class UpdateUserJob < ApplicationJob
  queue_as :stripe

  def perform(user, hash)
    user.update(hash)
  end
end
