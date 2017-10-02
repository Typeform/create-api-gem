require 'minitest/autorun'
require 'create_api_gem'

class ImagesTest < TestBase
  def test_crud_operations
    image = Image.full_example

    create_image = CreateImageRequest.new(token, image)
    assert_equal create_image.success?, true
    assert_equal image.same?(create_image.image), true
    image = create_image.image

    retrieve_image = RetrieveImageRequest.new(image, accept: 'json')
    assert_equal retrieve_image.success?, true
    assert_equal image.same?(retrieve_image.image), true
    image = retrieve_image.image

    delete_image = DeleteImageRequest.new(token, image)
    assert_equal delete_image.success?, true
  end

  def test_same_method; end

  def test_retrieve_all_images_request; end

  def test_retrieve_frame_request; end
end
