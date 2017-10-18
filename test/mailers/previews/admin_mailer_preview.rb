
class AdminMailerPreview < ActionMailer::Preview
  def update_email
    AdminMailer.update_email(Admin.first, Admin.last)
  end

  def send_email
      AdminMailer.send_message(Admin.first.email, Admin.last.email, "Subject teste","lorem ipsum")
  end
end