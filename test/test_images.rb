# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

class ImagesTest < TestBase
  def test_all_requests
    image = Image.full_example

    create_image = CreateImageRequest.new(image)
    assert_equal create_image.success?, true
    image = create_image.image

    retrieve_image = RetrieveImageRequest.new(image, accept: 'json')
    assert_equal retrieve_image.success?, true
    assert_equal image.id == retrieve_image.image.id, true
    assert_equal image.file_name == retrieve_image.image.file_name, true
    assert_equal image.media_type == retrieve_image.image.media_type, true
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
