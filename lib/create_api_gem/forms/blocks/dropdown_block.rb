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
  class DropdownBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :alphabetical_order, :choices, :required, :attachment

    def initialize(id: nil, title: nil, type: :dropdown, ref: nil, description: nil, alphabetical_order: nil,
                  choices: nil, required: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @alphabetical_order = alphabetical_order
      @choices = choices || DropdownBlock.choices
      @required = required
      @attachment = attachment
    end

    def self.choices
      [
        { label: 'choice 1' },
        { label: 'choice 2' }
      ]
    end

    def payload
      payload = {}
      payload[:properties] = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:ref] = ref unless ref.nil?
      payload[:id] = id unless id.nil?
      payload[:properties][:choices] = choices
      payload[:properties][:description] = description unless description.nil?
      payload[:properties][:alphabetical_order] = alphabetical_order unless alphabetical_order.nil?
      unless required.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      same_choices?(actual.choices) &&
        (alphabetical_order.nil? ? DropdownBlock.default.alphabetical_order : alphabetical_order) == actual.alphabetical_order &&
        (required.nil? ? DropdownBlock.default.required : required) == actual.required
    end

    def same_choices?(actual_choices)
      choices.zip(actual_choices).all? do |expected, actual|
        (!expected.key?(:id) || expected[id] == actual[id]) &&
          expected[:label] == actual[:label]
      end
    end

    def self.default
      DropdownBlock.new(
        choices: choices,
        alphabetical_order: false,
        required: false
      )
    end

    def self.full_example(id: nil)
      DropdownBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        id: id,
        choices: choices,
        alphabetical_order: true,
        required: true,
        attachment: Block.attachment
      )
    end
  end
end