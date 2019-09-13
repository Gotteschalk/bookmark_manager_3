require 'pg'
require 'uri'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks")
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
  end

  def self.add(title, url)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{url}') RETURNING id, title, url;")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id=#{id};")
  end

  def self.update(id, title, url)
    return false unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title ='#{title}' WHERE id = #{id} RETURNING id, title, url;")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
  end

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end
end
