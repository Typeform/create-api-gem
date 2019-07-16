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
  class Block
    def self.all_types
      {
        'date block' => DateBlock,
        'dropdown block' => DropdownBlock,
        'email block' => EmailBlock,
        'file upload block' => FileUploadBlock,
        'group block' => GroupBlock,
        'legal block' => LegalBlock,
        'long text block' => LongTextBlock,
        'multiple choice block' => MultipleChoiceBlock,
        'number block' => NumberBlock,
        'opinion scale block' => OpinionScaleBlock,
        'payment block' => PaymentBlock,
        'picture choice block' => PictureChoiceBlock,
        'rating block' => RatingBlock,
        'short text block' => ShortTextBlock,
        'statement block' => StatementBlock,
        'website block' => WebsiteBlock,
        'yes no block' => YesNoBlock,
        'phone number block' => PhoneNumberBlock
      }
    end

    def self.from_response(response)
      response[:type] = response[:type].to_sym
      if response[:type] == :group
        response[:properties][:fields].map! { |field| Block.from_response(field) } unless response[:properties][:fields].nil?
      end
      properties = response[:properties] || {}
      validations = response[:validations] || {}
      block_params = response.keep_if { |k, _| k != :properties && k != :validations } || {}
      params = properties.merge(validations).merge(block_params)
      all_types.fetch(block_symbol_to_string(response[:type])).new(params)
    end

    def same?(actual)
      (id.nil? || id == actual.id) &&
        type == actual.type &&
        title == actual.title &&
        (ref.nil? || ref == actual.ref) &&
        (description.nil? || description == actual.description) &&
        (respond_to?(:attachment) ? same_attachment?(actual.attachment) : true) &&
        same_extra_attributes?(actual)
    end

    def same_attachment?(actual_attachment)
      return true if attachment.nil?

      type = attachment[:type]
      case type
      when 'image'
        return (attachment[:href].start_with?("#{APIConfig.image_api_request_url}/images/") && actual_attachment[:href].start_with?("#{APIConfig.image_api_request_url}/images/"))
      when 'video'
        return attachment == actual_attachment
      else
        return false
      end
    end

    def self.attachment
      [Block.image_attachment_payload, Block.video_attachment_payload].sample
    end

    def self.image_attachment_payload(image_id: 'default')
      { type: 'image', href: "#{APIConfig.image_api_request_url}/images/#{image_id}" }
    end

    def self.video_attachment_payload(video_url: 'https://www.youtube.com/watch?v=Uui3oT-XBxs', scale: 0.6)
      { type: 'video', href: video_url, scale: scale }
    end

    def self.block_symbol_to_string(symbol)
      string = symbol.to_s
      string.sub!('_', ' ')
      string + ' block'
    end
  end
end
