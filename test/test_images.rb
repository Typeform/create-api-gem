require 'minitest/autorun'
require 'create_api_gem'

class ImagesTest < Minitest::Test
  def token
    ENV['TYPEFORM_API_TOKEN']
  end

  def test_crud_operations
    image = Image.new

    create_image = CreateImageRequest.new(token, image)
    assert_equal create_image.success?, true
    assert_equal image.same?(create_image.image), true
  end

  def test_same_method

  end

end
