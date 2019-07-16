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
  class RatingBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :steps, :shape, :required, :attachment

    def initialize(id: nil, title: nil, type: :rating, ref: nil, description: nil, steps: nil, shape: nil,
                  required: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @steps = steps
      @shape = shape
      @required = required
      @attachment = attachment
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:ref] = ref unless ref.nil?
      payload[:id] = id unless id.nil?
      unless description.nil? && steps.nil? && shape.nil?
        payload[:properties] = {}
        payload[:properties][:description] = description unless description.nil?
        payload[:properties][:steps] = steps unless steps.nil?
        payload[:properties][:shape] = shape unless shape.nil?
      end
      unless required.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required unless required.nil?
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      (steps.nil? ? RatingBlock.default.steps : steps) == actual.steps &&
        (shape.nil? ? RatingBlock.default.shape : shape) == actual.shape &&
        (required.nil? ? RatingBlock.default.required : required) == actual.required
    end

    def self.default
      RatingBlock.new(
        steps: 3,
        shape: 'star',
        required: false
      )
    end

    def self.full_example(id: nil)
      RatingBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        steps: 8,
        shape: 'heart',
        id: id,
        required: true,
        attachment: Block.attachment
      )
    end
  end
end
