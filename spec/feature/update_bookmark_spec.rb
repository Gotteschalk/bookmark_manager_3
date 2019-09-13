feature 'Update bookmark' do
  scenario 'user updates a bookmark from the database' do

    bookmark = Bookmark.add('Makers Academy', 'http://www.makersacademy.com')

    visit('/bookmarks')
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"
    fill_in('url', with: 'http://www.makers.com')
    fill_in('title', with: 'Makers')
    click_button 'Update'
    expect(current_path).to eq '/bookmarks'
    expect(page).to have_link('Makers', href: 'http://www.makers.com')
    expect(page).to_not have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end
end
