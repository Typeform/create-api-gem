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
  class LogicConditionDetails
    attr_accessor :reference_type, :reference, :value_type, :value

    def initialize(reference_type: nil, reference: nil, value_type: nil, value: nil)
      @reference_type = reference_type
      @reference = reference
      @value_type = value_type
      @value = value
    end

    def self.from_response(payload)
      reference_object = payload.first
      value_object = payload.last
      reference_type = reference_object[:type] unless reference_object.nil?
      reference = reference_object[:value] unless reference_object.nil?
      value_type = value_object[:type] unless value_object.nil?
      value = value_object[:value] unless value_object.nil?
      LogicConditionDetails.new(
        reference_type: reference_type,
        reference: reference,
        value_type: value_type,
        value: value
      )
    end

    def payload
      if reference_type.nil?
        []
      else
        [{ type: reference_type, value: reference }, { type: value_type, value: value }]
      end
    end

    def same?(actual)
      reference_type == actual.reference_type &&
        reference == actual.reference &&
        value_type == actual.value_type &&
        value == actual.value
    end
  end
end
