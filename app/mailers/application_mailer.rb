class ApplicationMailer < ActionMailer::Base
  default from: 'rentalservices.updates@gmail.com'

  def car_available_email_notification(user)
    mail(to: user, subject: 'Car you wanted on rental services just became available!')
  end
end
