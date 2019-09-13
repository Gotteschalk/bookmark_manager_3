require 'databaseconnection'

describe DatabaseConnection do

  describe '.setup' do
    it 'connects to the database' do
      DatabaseConnection.setup('bookmark_manager_test')
      expect(DatabaseConnection.connection.db).to eq 'bookmark_manager_test'
    end
  end

  describe '.query' do
    it 'executes an SQL command on the database' do
      connection = DatabaseConnection.setup('bookmark_manager_test')
      expect(connection).to receive(:exec).with("INSERT INTO bookmarks (title, url) VALUES ('Yahoo', 'yahoo.com');")
      DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES ('Yahoo', 'yahoo.com');")
    end
  end
end
