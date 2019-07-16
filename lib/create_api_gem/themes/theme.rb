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
  class Theme
    attr_accessor :id, :name, :font, :colors, :visibility, :has_transparent_button, :background

    def initialize(id: nil, name: nil, font: nil, colors: nil, visibility: nil, has_transparent_button: nil, background: nil)
      @id = id
      @name = name || DataGenerator.title
      @font = font || 'Arial'
      @colors = colors || Theme.colors
      @visibility = visibility || 'private'
      @has_transparent_button = has_transparent_button
      @background = background
    end

    def self.default
      Theme.new(
        id: 'gJ3gfQ',
        name: 'Default',
        colors: [
          question: '#3D3D3D',
          answer: '#4FB0AE',
          button: '#4FB0AE',
          background: '#FFFFFF'
        ],
        font: 'Karla',
        has_transparent_button: false,
        visibility: 'private'
      )
    end

    def self.full_example
      Theme.new(
        name: DataGenerator.title,
        colors: colors,
        font: 'Nixie One',
        has_transparent_button: true,
        visibility: 'private',
        background: Background.full_example
      )
    end

    def self.colors
      {
        question: DataGenerator.color_code,
        answer: DataGenerator.color_code,
        button: DataGenerator.color_code,
        background: DataGenerator.color_code
      }
    end

    def payload
      payload = {
        name: name,
        font: font,
        colors: colors
      }
      payload[:has_transparent_button] = has_transparent_button unless has_transparent_button.nil?
      payload[:visibility] = visibility unless visibility.nil?
      payload[:background] = background.payload unless background.nil?
      payload.to_json
    end

    def self.from_response(payload)
      background = payload[:background].nil? ? nil : Background.from_response(payload[:background])
      new(
        id: payload[:id],
        name: payload[:name],
        font: payload[:font],
        colors: payload[:colors],
        visibility: payload[:visibility],
        has_transparent_button: payload[:has_transparent_button],
        background: background
      )
    end

    def same?(actual)
      (id.nil? || id == actual.id) &&
        name == actual.name &&
        colors == actual.colors &&
        colors.keys == %i[question answer button background] &&
        font == actual.font &&
        (visibility.nil? ? Theme.default.visibility : visibility) == actual.visibility &&
        (has_transparent_button.nil? ? Theme.default.has_transparent_button : has_transparent_button) == actual.has_transparent_button &&
        (background.nil? || background.same?(actual.background))
    end
  end
end
