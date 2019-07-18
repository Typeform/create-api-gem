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
  class LogicJump < LogicAction
    attr_accessor :to_type, :to_ref, :logic_condition

    def initialize(to_type: nil, to_ref: nil, logic_condition: nil)
      @to_type = to_type
      @to_ref = to_ref
      @logic_condition = logic_condition
    end

    def self.from_response(payload)
      to_type = payload[:details][:to][:type]
      to_ref = payload[:details][:to][:value]
      logic_condition = LogicCondition.from_response(payload[:condition])
      LogicJump.new(to_type: to_type, to_ref: to_ref, logic_condition: logic_condition)
    end

    def self.create_field_logic_jump(form, block_type)
      logic_block = form.blocks.find { |block| Block.block_symbol_to_string(block.type) == block_type }
      to_ref = if form.blocks.last.ref == logic_block.ref
                 form.blocks.first.ref
               else
                 form.blocks.last.ref
               end
      logic_condition = LogicCondition.generate_from_block(logic_block)
      LogicJump.new(to_type: 'field', to_ref: to_ref, logic_condition: logic_condition)
    end

    def self.create_always_jump(form)
      LogicJump.new(to_type: 'field', to_ref: form.blocks.first.ref, logic_condition: LogicCondition.new(op: 'always'))
    end

    def self.create_hidden_logic_jump(form)
      logic_condition_details = LogicConditionDetails.new(reference_type: 'hidden', reference: form.hidden[0], value_type: 'constant', value: 'abc')
      logic_condition = LogicCondition.new(op: 'equal', vars: [logic_condition_details])
      LogicJump.new(to_type: 'field', to_ref: form.blocks.first.ref, logic_condition: logic_condition)
    end

    def self.create_variable_logic_jump(form)
      logic_condition_details = LogicConditionDetails.new(reference_type: 'variable', reference: 'score', value_type: 'constant', value: 5)
      logic_condition = LogicCondition.new(op: 'equal', vars: [logic_condition_details])
      LogicJump.new(to_type: 'field', to_ref: form.blocks.first.ref, logic_condition: logic_condition)
    end

    def self.create_nested_logic_jump(form)
      logic_condition1 = LogicCondition.generate_from_block(form.blocks[0])
      logic_condition2 = LogicCondition.generate_from_block(form.blocks[1])
      logic_condition3 = LogicCondition.generate_from_block(form.blocks[2])
      and_logic_condition = LogicCondition.new(op: 'and', vars: [logic_condition1, logic_condition2])
      or_logic_condition = LogicCondition.new(op: 'or', vars: [logic_condition3, and_logic_condition])
      LogicJump.new(to_type: 'field', to_ref: form.blocks.last.ref, logic_condition: or_logic_condition)
    end

    def self.create_thankyou_logic_jump(form)
      logic_condition = LogicCondition.generate_from_block(form.blocks[0])
      LogicJump.new(to_type: 'thankyou', to_ref: form.thank_you_screens.first.ref, logic_condition: logic_condition)
    end

    def payload
      payload = {}
      payload[:action] = 'jump'
      payload[:details] = { to: { type: to_type, value: to_ref } }
      payload[:condition] = logic_condition.payload
      payload
    end

    def same?(actual)
      to_type == actual.to_type &&
        to_ref == actual.to_ref &&
        logic_condition.same?(actual.logic_condition)
    end
  end
end
