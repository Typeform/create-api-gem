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
  class MultipleChoiceBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :randomize, :allow_multiple_selection, :allow_other_choice,
                  :vertical_alignment, :choices, :required, :attachment

    def initialize(id: nil, title: nil, type: :multiple_choice, ref: nil, description: nil, randomize: nil,
                  allow_multiple_selection: nil, allow_other_choice: nil, vertical_alignment: nil,
                  choices: nil, required: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @randomize = randomize
      @allow_multiple_selection = allow_multiple_selection
      @allow_other_choice = allow_other_choice
      @vertical_alignment = vertical_alignment
      @choices = choices || MultipleChoiceBlock.choices
      @required = required
      @attachment = attachment
    end

    def self.choices
      [
        {
          label: 'choice 1',
          ref: DataGenerator.field_ref
        },
        {
          label: 'choice 2',
          ref: DataGenerator.field_ref
        }
      ]
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:ref] = ref unless ref.nil?
      payload[:id] = id unless id.nil?
      payload[:properties] = {}
      payload[:properties][:choices] = choices
      payload[:properties][:description] = description unless description.nil?
      payload[:properties][:randomize] = randomize unless randomize.nil?
      payload[:properties][:allow_multiple_selection] = allow_multiple_selection unless allow_multiple_selection.nil?
      payload[:properties][:allow_other_choice] = allow_other_choice unless allow_other_choice.nil?
      payload[:properties][:vertical_alignment] = vertical_alignment unless vertical_alignment.nil?
      unless required.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      same_choices?(actual.choices) &&
        (randomize.nil? ? MultipleChoiceBlock.default.randomize : randomize) == actual.randomize &&
        (allow_multiple_selection.nil? ? MultipleChoiceBlock.default.allow_multiple_selection : allow_multiple_selection) == actual.allow_multiple_selection &&
        (allow_other_choice.nil? ? MultipleChoiceBlock.default.allow_other_choice : allow_other_choice) == actual.allow_other_choice &&
        (vertical_alignment.nil? ? MultipleChoiceBlock.default.vertical_alignment : vertical_alignment) == actual.vertical_alignment &&
        (required.nil? ? MultipleChoiceBlock.default.required : required) == actual.required
    end

    def same_choices?(actual_choices)
      choices.zip(actual_choices).all? do |expected, actual|
        (!expected.key?(:id) || expected[:id] == actual[:id]) &&
          (!expected.key?(:ref) || expected[:ref] == actual[:ref]) &&
          expected[:label] == actual[:label]
      end
    end

    def self.default
      MultipleChoiceBlock.new(
        choices: choices,
        randomize: false,
        allow_multiple_selection: false,
        allow_other_choice: false,
        vertical_alignment: true,
        required: false
      )
    end

    def self.full_example(id: nil)
      MultipleChoiceBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        id: id,
        randomize: true,
        allow_multiple_selection: true,
        allow_other_choice: true,
        vertical_alignment: true,
        choices: choices,
        required: true,
        attachment: Block.attachment
      )
    end
  end
end
