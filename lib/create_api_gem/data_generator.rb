require 'ffaker'

module DataGenerator
  def self.title
    FFaker::Movie.title
  end

  def self.title_with_markdown
    FFaker::Movie.title + ' with _some *accompanying* markdown_'
  end

  def self.song
    FFaker::Music.song
  end

  def self.email
    FFaker::Internet.email
  end

  def self.user_name
    FFaker::Internet.user_name
  end

  def self.password
    FFaker::Internet.password
  end

  def self.first_name
    FFaker::Name.first_name
  end

  def self.country
    FFaker::Address.country
  end

  def self.color_code
    '#' + SecureRandom.hex(3)
  end

  def self.field_ref
    SecureRandom.hex(6)
  end

  def self.uuid
    SecureRandom.uuid
  end

  def self.network_id
    SecureRandom.hex(5)
  end

  def self.landing_id
    SecureRandom.hex(16)
  end

  def self.landing_date
    (Time.now - 120 - rand(60)).utc.round
  end

  def self.submission_date
    (Time.now - rand(60)).utc.round
  end
end
