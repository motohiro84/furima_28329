# Preview all emails at http://localhost:3000/rails/mailers/my_mailer
class MyMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/my_mailer/sendmail_confirm
  def sendmail_confirm
    MyMailer.sendmail_confirm
  end
end
