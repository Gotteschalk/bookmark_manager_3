feature "URL's have to be valid" do
  scenario "it flashes an error when an edited url is invalid" do
    DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('http://www.google.com', 'google');")

    visit '/bookmarks'
    first('.bookmark').click_button 'Edit'
    fill_in 'title', with: 'Test'
    fill_in 'url', with: 'not a url'
    click_button 'Update'

    expect(page).to have_content("URL must be valid")
  end

  scenario "it flashes an error when an new url is invalid" do
    visit '/bookmarks'
    click_button 'add'
    fill_in 'title', with: 'Test'
    fill_in 'url', with: 'not a url'
    click_button 'Add'

    expect(page).to have_content("URL must be valid")
  end

  scenario "it doesn't flash an error when a new url is valid" do
    visit '/bookmarks'
    click_button 'add'
    fill_in 'title', with: 'Google'
    fill_in 'url', with: 'http://www.google.com'
    click_button 'Add'

    expect(page).not_to have_content("URL must be valid")
  end
  # scenario "it doesnot change the database info with the invalid URL" do
  #
  # end
end
