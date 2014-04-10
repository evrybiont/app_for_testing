When(/^user filled form with valid information$/) do
  user = attributes_for :user
  @profile = attributes_for :profile
  within('#new_user') do
    fill_in 'user_profile_attributes_first_name', with: @profile[:first_name]
    fill_in 'user_profile_attributes_last_name',  with: @profile[:last_name]
    fill_in 'user_email',                         with: user[:email]
    fill_in 'user_password',                      with: user[:password]
    fill_in 'user_password_confirmation',         with: user[:password]
  end
  evaluate_script("$('<input/>', { type: 'hidden', name: 'authenticity_token', value: 'token'} ).appendTo('#new_user')")
end

Then(/^click sign up button$/) do
  click_button I18n.t('signups.sign_up')
end

Then(/^redirect him to top(\d+) hotels page$/) do |arg1|
  expect(page).to have_content @profile[:first_name] + ' ' + @profile[:last_name]
end

Then(/^see fields errors$/) do
  expect(page).to have_content(I18n.t('errors.messages.blank'), count: 4)
  expect(page.all('.help-inline').count).to eql 4 # 4 - form errors tag
end

