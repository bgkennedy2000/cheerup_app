class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      user = User.from_omniauth(request.env["omniauth.auth"])
      if user.persisted?
        flash.notice = "Signed in Through Twitter"
        sign_in_and_redirect user
      else
        session["devise.user_attributes"] = user.attributes
        flash.notice = "Problem creating account. "+user.errors.full_messages.join(". ")+"."
        redirect_to new_user_registration_url
      end
    end
  end