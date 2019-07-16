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
  class OpinionScaleBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :steps, :start_at_one, :labels, :required, :attachment

    def initialize(id: nil, title: nil, type: :opinion_scale, ref: nil, description: nil, steps: nil, start_at_one: nil,
                  labels: nil, required: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @steps = steps
      @start_at_one = start_at_one
      @labels = labels
      @required = required
      @attachment = attachment
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:id] = id unless id.nil?
      payload[:ref] = ref unless ref.nil?
      unless description.nil? && steps.nil? && start_at_one.nil? && labels.nil?
        payload[:properties] = {}
        payload[:properties][:description] = description unless description.nil?
        payload[:properties][:steps] = steps unless steps.nil?
        payload[:properties][:start_at_one] = start_at_one unless start_at_one.nil?
        payload[:properties][:labels] = labels unless labels.nil?
      end
      unless required.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required unless required.nil?
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      (labels.nil? || labels == actual.labels) &&
        (steps.nil? ? OpinionScaleBlock.default.steps : steps) == actual.steps &&
        (start_at_one.nil? ? OpinionScaleBlock.default.start_at_one : start_at_one) == actual.start_at_one &&
        (required.nil? ? OpinionScaleBlock.default.required : required) == actual.required
    end

    def self.default
      OpinionScaleBlock.new(
        steps: 11,
        start_at_one: false,
        required: false
      )
    end

    def self.full_example(id: nil)
      OpinionScaleBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        steps: 7,
        id: id,
        start_at_one: true,
        labels: { left: 'beg', center: 'mid', right: 'end' },
        required: true,
        attachment: Block.attachment
      )
    end
  end
end
