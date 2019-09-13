feature 'add bookmark' do
  scenario 'user adds bookmark to the database' do

  Bookmark.add('Makers Academy', 'http://www.makersacademy.com')
  Bookmark.add('Destroy all Software Homepage', 'http://www.destroyallsoftware.com')
  Bookmark.add('Google Homepage', 'http://www.google.com')

  visit('/bookmarks')
  click_button 'Add Bookmark'
  fill_in :url, with: 'http://www.cosmopolitan.com'
  fill_in :title, with: 'Cosmopolitan'
  click_button 'Add to bookmarks'

  expect(page).to have_link('Cosmopolitan', href: 'http://www.cosmopolitan.com')
  expect(page).to have_content 'Makers Academy'
  expect(page).to have_content 'Google Homepage'
  expect(page).to have_content 'Destroy all Software Homepage'
  end

end
