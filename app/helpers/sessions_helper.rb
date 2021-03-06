module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.password_salt]
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def admin_user
    if  !current_user.admin?
      flash[:error] = "You are not authorized to do this"
      redirect_to(root_path)
    end 
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    if request.xhr?
      head(:forbidden)
    else
      redirect_to login_path, :notice => "Please sign in to access this page."
    end
  end
  
  def current_user?(user)
    user == current_user
  end

  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

end
