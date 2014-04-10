When(/^user click on add_hotel link$/) do
  click_link I18n.t('hotels.add_hotel')
end

Then(/^he has access to create hotel$/) do
  find('#new_hotel')
end

Then(/^he has receive error message$/) do
  expect(page).to have_content I18n.t('errors.required_user')
end

When(/^user filled hotel form$/) do
  hotel = attributes_for :hotel
  address = attributes_for :address
  within('#new_hotel') do
    fill_in 'hotel_title', with: hotel[:title]
    select hotel[:star_rating]
    check(find("input[type='checkbox']")[:id])
    fill_in 'hotel_price_for_room', with: hotel[:price_for_room]
    select(address[:country], from: 'hotel_address_attributes_country')
    fill_in 'hotel_address_attributes_state', with: address[:state]
    fill_in 'hotel_address_attributes_sity', with: address[:sity]
    fill_in 'hotel_address_attributes_street', with: address[:street]
  end
  find('#hotel_photo')
  find('#hotel_room_description')
end

Then(/^click on create_hotel button$/) do
  click_button I18n.t('hotels.create_hotel')
end

Then(/^see success message$/) do
  expect(page).to have_content I18n.t('hotels.create')
end

Then(/^see errors$/) do
  expect(page).to have_content(I18n.t('errors.messages.blank'), count: 6)
  expect(page).to have_content(I18n.t('errors.messages.not_a_number'), count: 1)
  expect(page.all('.help-inline').count).to eql 7 # 7- form  errors tag
end

When(/^click edit_hotel button$/) do
  click_link I18n.t('hotels.edit_hotel')
end

Then(/^then he has access to update hotel form$/) do
  find("#edit_hotel_#{ @hotel.id }")
end

When(/^publisher click on update_hotel button$/) do
  click_button I18n.t('hotels.update_hotel')
end

Then(/^see success update message$/) do
  find('.alert.alert-dismissable.alert-success')
  find('.close')
  expect(page).to have_content I18n.t('hotels.update')
end

Then(/^he not see edit and destroy button$/) do
  has_no_link? I18n.t('hotels.edit_hotel')
  has_no_link? I18n.t('hotels.destroy_hotel')
end

When(/^click destroy_hotel button$/) do
  click_link I18n.t('hotels.destroy_hotel')
end

Then(/^see success destroy message$/) do
  expect(page).to have_content I18n.t('hotels.destroy')
end
