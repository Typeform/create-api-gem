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
  class StatementBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :hide_marks, :button_text, :attachment

    def initialize(id: nil, title: nil, type: :statement, ref: nil, description: nil, hide_marks: nil,
                  button_text: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @hide_marks = hide_marks
      @button_text = button_text
      @attachment = attachment
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:id] = id unless id.nil?
      payload[:ref] = ref unless ref.nil?
      unless description.nil? && hide_marks.nil? && button_text.nil?
        payload[:properties] = {}
        payload[:properties][:description] = description unless description.nil?
        payload[:properties][:hide_marks] = hide_marks unless hide_marks.nil?
        payload[:properties][:button_text] = button_text unless button_text.nil?
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      (hide_marks.nil? ? StatementBlock.default.hide_marks : hide_marks) == actual.hide_marks &&
        (button_text.nil? ? StatementBlock.default.button_text : button_text) == actual.button_text
    end

    def self.default
      StatementBlock.new(button_text: 'Continue', hide_marks: false)
    end

    def self.full_example(id: nil)
      StatementBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        hide_marks: true,
        id: id,
        button_text: 'Click me!',
        attachment: Block.attachment
      )
    end
  end
end