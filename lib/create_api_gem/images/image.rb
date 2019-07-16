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

module Typeform
  class Image
    attr_accessor :id, :image, :media_type, :file_name, :width, :height, :has_alpha, :avg_color

    def initialize(id: nil, image: nil, media_type: nil, file_name: nil, width: nil, height: nil, has_alpha: nil, avg_color: nil)
      @id = id
      @image = image
      @media_type = media_type
      @file_name = file_name
      @width = width
      @height = height
      @has_alpha = has_alpha
      @avg_color = avg_color
    end

    def self.from_response(payload)
      Image.new(
        id: payload[:id],
        media_type: payload[:media_type],
        file_name: payload[:file_name],
        width: payload[:width],
        height: payload[:height],
        has_alpha: payload[:has_alpha],
        avg_color: payload[:avg_color]
      )
    end

    def payload
      {
        image: image,
        media_type: media_type,
        file_name: file_name
      }.to_json
    end

    def same?(actual)
      (id.nil? || id == actual.id) &&
        (media_type.nil? || media_type == actual.media_type) &&
        (file_name.nil? || file_name == actual.file_name) &&
        (width.nil? || width == actual.width) &&
        (height.nil? || height == actual.height) &&
        (has_alpha.nil? || has_alpha == actual.has_alpha) &&
        (avg_color.nil? || avg_color == actual.avg_color)
    end

    def src
      "#{APIConfig.image_api_request_url}/images/#{id}"
    end

    def self.full_example
      Image.new(
        image: File.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'data', 'typeform_image.txt'))),
        media_type: 'image/gif',
        file_name: 'typeform.gif',
        width: 530,
        height: 350,
        has_alpha: true,
        avg_color: '5a6067'
      )
    end
  end
end
