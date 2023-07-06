class UserMailer < ApplicationMailer

    def default_password
        @email = params[:email]
        mail(to: @email, subject: "Default-Password")
    end

end
