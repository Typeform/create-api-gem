class ImagesTest < TestBase
  def test_all_requests
    image = Image.full_example

    create_image = CreateImageRequest.new(image)
    assert_equal create_image.success?, true
    assert_equal image.same?(create_image.image), true
    image = create_image.image

    retrieve_image = RetrieveImageRequest.new(image, accept: 'json')
    assert_equal retrieve_image.success?, true
    assert_equal image.same?(retrieve_image.image), true
    image = retrieve_image.image

    retrieve_frame = RetrieveFrameRequest.new(image, 'first')
    assert_equal retrieve_frame.success?, true

    retrieve_all_images = RetrieveAllImagesRequest.new
    assert_equal retrieve_all_images.success?, true

    delete_image = DeleteImageRequest.new(image)
    assert_equal delete_image.success?, true
  end

  def test_same_method
    image = Image.full_example
    same_image = image.dup
    assert_equal image.same?(same_image), true

    different_image = image.dup
    different_image.file_name = 'different_file_name'
    assert_equal image.same?(different_image), false
  end
end
