module ApplicationHelper
  def active(action)
    params[:action] == action ? 'active' : ''
  end

  def signin_out
    if current_user
      link_to t('navbar.log_out'), logins_path, method: 'delete'
    else
      link_to t('navbar.login'), logins_path
    end
  end

  def user_name
    current_user ? current_user.full_name : ''
  end

  def flash_class
    flash[:error] ? 'alert-danger' : 'alert-success'
  end
end
