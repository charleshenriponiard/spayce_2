namespace :project do
  desc "send message one day before expiry project and when the project it's just expired"
  task expired: :environment do
    projects = Project.will_expire
    projects.map do |project|
      ClientMailer.client_reminder(project).deliver_later
      UserMailer.user_reminder(project).deliver_later
    end
    projects_expired = Project.expired
    projects_expired.each do |project_expired|
      ExpireProjectJob.perform_later(project_expired)
    end
  end
end
