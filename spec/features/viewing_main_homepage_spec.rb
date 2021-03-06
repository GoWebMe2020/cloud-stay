# frozen_string_literal: true

require 'capybara/rspec'
require_relative '../../app'

feature 'visiting the clouds listing page' do
  before do
    connection = PG.connect(dbname: 'cloud_stay_test')
    user = User.user_create(username: 'Glenn', password: 'Jerusha')
    cloud = Cloud.create(name: 'Cloud Nine', description: 'Lovely property to have a Heavenly Day', price: '49,99', user_id: user.id) 
    Cloud.create(name: 'Cloud Nine NEW', description: 'Lovely property to have a Heavenly Day after the storm', price: '99,99', user_id: user.id)
    visit('/clouds')
  end
  # before block and code here for capybara to login first

  it 'shows available clouds' do
    expect(page).to have_content('Available clouds')
    expect(page).to have_content('Cloud Nine')
    expect(page).to have_content('Cloud Nine NEW')
  end

  it 'shows page links' do
    expect(page).to have_content('+')
    expect(page).to have_content('Sign Out')
    # expect(page).to have_content('Requests', href: '/requests')
  end

  it 'shows boxes for the dates from / to availability' do
    expect(page).to have_content('available_from')
    expect(page).to have_content('available_to')
    expect(page).to have_content('Search')
  end
end
