Before '@logins_page' do
  visit logins_path
end

Before '@create_user' do
  create_user
end

Before '@log_in' do
  visit logins_path
  create_user
  within('.user') do
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
  end
  click_button I18n.t('logins.log_in')
end

Before '@root_page' do
  visit '/'
end

Before '@create_hotel_page' do
  visit new_hotel_path
end

Before '@create_hotel' do
  @hotel = create(:hotel, user: @user)
  create(:address, hotel: @hotel)
end

Before '@show_hotel_page' do
  visit hotel_path @hotel
end

Before '@update_hotel_page' do
  visit edit_hotel_path @hotel
end

Before '@signup_page' do
  visit new_signup_path
end

def create_user
  profile = create :profile
  @user = profile.user
end
