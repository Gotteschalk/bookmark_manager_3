feature 'Delete bookmark' do
  scenario 'user deletes a bookmark from the database' do

  Bookmark.add('Makers Academy', 'http://www.makersacademy.com')

  visit('/bookmarks')
  expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

  first('.bookmark').click_button 'Delete'

  expect(current_path).to eq '/bookmarks'
  expect(page).to_not have_link('Makers Academy', href: 'http://www.makersacademy.com')

  end
end
