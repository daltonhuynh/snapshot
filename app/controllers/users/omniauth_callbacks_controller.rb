class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # oauth 2
  def facebook
    omniauth = env["omniauth.auth"]
    @user = User.find_for_facebook_oauth(omniauth, current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = omniauth
      redirect_to root_path, :flash => {:error => "Error"}
    end
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def failure
    redirect_to cancel_user_registration_path, :flash => {:error => "Could not log you in. #{params[:message]}"}
  end

end
