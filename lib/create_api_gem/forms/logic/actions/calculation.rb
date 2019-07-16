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

require_relative '../logic_action'

module Typeform
  class Calculation < LogicAction
    attr_accessor :action_type, :numeric_value, :target_ref, :logic_condition

    def initialize(action_type: nil, numeric_value: nil, target_ref: nil, logic_condition: nil)
      @action_type = action_type
      @numeric_value = numeric_value
      @target_ref = target_ref
      @logic_condition = logic_condition
    end

    def self.from_response(payload)
      action_type = payload[:action]
      target_ref = payload[:details][:target][:value]
      numeric_value = payload[:details][:value][:value]
      logic_condition = LogicCondition.from_response(payload[:condition])
      Calculation.new(action_type: action_type, numeric_value: numeric_value, target_ref: target_ref, logic_condition: logic_condition)
    end

    def payload
      payload = {}
      payload[:action] = action_type
      payload[:details] = { target: { type: 'variable', value: target_ref } }
      payload[:details][:value] = { type: 'constant', value: numeric_value }
      payload[:condition] = logic_condition.payload
      payload
    end

    def self.full_example(block)
      is_blocks = %i[multiple_choice picture_choice yes_no legal]
      logic_condition = if is_blocks.include?(block.type)
                          LogicCondition.generate_from_block(block, op: 'is')
                        elsif block.type == :date
                          LogicCondition.generate_from_block(block, op: 'on')
                        elsif block.type == :file_upload
                          LogicCondition.generate_from_block(block, op: 'answered')
                        else
                          LogicCondition.generate_from_block(block, op: 'equal')
                        end
      Calculation.new(
        action_type: 'add',
        numeric_value: 5,
        target_ref: 'score',
        logic_condition: logic_condition
      )
    end

    def same?(actual)
      action_type == actual.action_type &&
        target_ref == actual.target_ref &&
        numeric_value == actual.numeric_value &&
        logic_condition.same?(actual.logic_condition)
    end
  end
end
