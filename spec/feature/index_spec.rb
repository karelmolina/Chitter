require 'spec_helper'
RSpec.feature 'get the index' do
  scenario 'index' do
    visit('/')
    expect(page).to have_content("Welcome To Chitter")
  end
  scenario 'all peeps' do
    visit('/')
    fill_in 'content', with: 'Hello im in chitter'
    click_button 'Peep'

    expect(page).to have_content'Hello im in chitter'
  end
end
