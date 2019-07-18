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
  class LogicCondition
    attr_accessor :op, :vars

    def initialize(op: nil, vars: [])
      @op = op
      @vars = vars
    end

    def vars_are_condition_details?
      vars.is_a?(LogicConditionDetails)
    end

    def self.from_response(payload)
      vars = []
      if payload[:vars].any?
        is_logic_condition_details = payload[:vars].detect { |var| var.key?(:op) }.nil?
        vars = is_logic_condition_details ? [LogicConditionDetails.from_response(payload[:vars])] : payload[:vars].map { |condition_payload| LogicCondition.from_response(condition_payload) }
      end
      LogicCondition.new(op: payload[:op], vars: vars)
    end

    def self.generate_from_block(block, op: nil)
      case block.type
      when :number, :opinion_scale, :rating
        op ||= 'lower_equal_than'
        logic_condition_details = LogicConditionDetails.new(reference_type: 'field', reference: block.ref, value_type: 'constant', value: 15)
      when :date
        op ||= 'not_on'
        logic_condition_details = LogicConditionDetails.new(reference_type: 'field', reference: block.ref, value_type: 'constant', value: '2017-01-01')
      when :yes_no, :legal
        op ||= 'is'
        logic_condition_details = LogicConditionDetails.new(reference_type: 'field', reference: block.ref, value_type: 'constant', value: true)
      when :file_upload
        op ||= 'answered'
        logic_condition_details = LogicConditionDetails.new(reference_type: 'field', reference: block.ref, value_type: 'constant', value: true)
      when :multiple_choice, :picture_choice
        op ||= 'is'
        logic_condition_details = LogicConditionDetails.new(reference_type: 'field', reference: block.ref, value_type: 'choice', value: block.choices.first.fetch(:ref))
      else
        op ||= 'contains'
        logic_condition_details = LogicConditionDetails.new(reference_type: 'field', reference: block.ref, value_type: 'constant', value: 'hello')
      end
      LogicCondition.new(op: op, vars: [logic_condition_details])
    end

    def payload
      payload = {}
      payload[:op] = op
      if vars.empty?
        payload[:vars] = []
      else
        payload[:vars] = vars.map(&:payload)
        payload[:vars].flatten!
      end
      payload
    end

    def same?(actual)
      op == actual.op &&
        same_vars?(actual.vars)
    end

    def same_vars?(actual_vars)
      vars.zip(actual_vars).all? do |expected, actual|
        expected.same?(actual)
      end
    end
  end
end
