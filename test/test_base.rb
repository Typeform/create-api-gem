require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
end
SimpleCov.command_name 'Gem Unit Tests'

require 'minitest/autorun'
require 'create_api_gem'

class TestBase < Minitest::Test
  def token
    ENV['TYPEFORM_API_TOKEN']
  end

  def email
    'maria_jose@typeform.com'
  end
end
