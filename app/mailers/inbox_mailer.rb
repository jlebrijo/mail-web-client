class InboxMailer < ActionMailer::Base
  def create_mail(user,message)
    @text = message[:body]
    mail(:from => user.email,
         :to => message[:to],
         :subject => message[:subject])
  end
end
