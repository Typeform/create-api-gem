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
  class NumberBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :required, :min_value, :max_value, :attachment

    def initialize(id: nil, title: nil, type: :number, ref: nil, description: nil, required: nil, min_value: nil,
                  max_value: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @required = required
      @min_value = min_value
      @max_value = max_value
      @attachment = attachment
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:ref] = ref unless ref.nil?
      payload[:id] = id unless id.nil?
      unless description.nil?
        payload[:properties] = {}
        payload[:properties][:description] = description
      end
      unless required.nil? && min_value.nil? && max_value.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required unless required.nil?
        payload[:validations][:min_value] = min_value unless min_value.nil?
        payload[:validations][:max_value] = max_value unless max_value.nil?
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      (min_value.nil? || min_value == actual.min_value) &&
        (max_value.nil? || max_value == actual.max_value) &&
        (required.nil? ? NumberBlock.default.required : required) == actual.required
    end

    def self.default
      NumberBlock.new(
        required: false
      )
    end

    def self.full_example(id: nil)
      NumberBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        id: id,
        required: true,
        min_value: 1,
        max_value: 500,
        attachment: Block.attachment
      )
    end
  end
end