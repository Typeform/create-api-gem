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

require_relative 'block'

module Typeform
  class YesNoBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :required, :attachment

    def initialize(id: nil, title: nil, type: :yes_no, ref: nil, description: nil, required: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @required = required
      @attachment = attachment
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:id] = id unless id.nil?
      payload[:ref] = ref unless ref.nil?
      unless description.nil?
        payload[:properties] = {}
        payload[:properties][:description] = description
      end
      unless required.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      (required.nil? ? YesNoBlock.default.required : required) == actual.required
    end

    def self.default
      YesNoBlock.new(
        required: false
      )
    end

    def self.full_example(id: nil)
      YesNoBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        required: true,
        attachment: Block.attachment,
        id: id
      )
    end
  end
end
