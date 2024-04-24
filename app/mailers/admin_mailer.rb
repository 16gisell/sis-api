class AdminMailer < ApplicationMailer
  def reset_password_instructions(admin)
    @admi = admin
    @token = admin.set_reset_password_token

    mail(to: @admin.email, subject: 'Cambio de password')
  end
end