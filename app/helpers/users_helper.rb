module UsersHelper
  def update_user_path(inst, frame_id)
    "/users/#{inst.id}/edit&frame_id=#{frame_id}"
  end

  def user_session_start(user)
    session[:user_id] = user.id
  end
  
  def user_in_session
    if @user_in_session.nil?
      @user_in_session = User.find_by(id: session[:user_id])
    else
      @user_in_session
    end
  end

  def user_in_session?
    user_in_session.present?
  end

  def authorize
    redirect_to :sign_in unless user_in_session?
  end

  def user_session_end
    session.delete(:user_id)
    @user_in_session = nil
  end
end
