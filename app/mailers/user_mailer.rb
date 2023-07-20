class UserMailer < ApplicationMailer

    def default_password(user)
        @user = user
        mail(to: @user.email, subject: "Your Default Password")
    end
end
