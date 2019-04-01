
feature 'index' do
  scenario 'is in test'do
    visit('/')
    expect(page).to have_content 'chitter_test'
  end
end
