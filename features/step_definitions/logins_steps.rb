When(/^user fill login form$/) do
  within('.user') do
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
  end
end

Then(/^click button$/) do
  click_button I18n.t('logins.log_in')
end

Then(/^redirect to top(\d+) page$/) do |arg1|
  expect(page).to have_content @user.full_name
end

Then(/^see error message$/) do
  expect(page).to have_content I18n.t('logins.fail')
end
