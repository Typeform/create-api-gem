require 'ffaker'

module DataGenerator
  def self.title
    FFaker::Movie.title
  end

  def self.description
    FFaker::Lorem.paragraph
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
end
