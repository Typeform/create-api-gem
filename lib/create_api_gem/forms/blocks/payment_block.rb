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
  class PaymentBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :required, :currency, :price, :show_button, :button_text, :attachment

    def initialize(id: nil, title: nil, type: :payment, ref: nil, description: nil, required: nil, currency: nil, price: nil,
                  show_button: nil, button_text: nil, attachment: nil)
      @id = id
      @title = title || DataGenerator.title
      @type = type
      @ref = ref
      @description = description
      @required = required
      @currency = currency || 'EUR'
      @price = price || { type: 'variable', value: 'price' }
      @show_button = show_button
      @button_text = button_text
      @attachment = attachment
    end

    def payload
      payload = {}
      payload[:title] = title
      payload[:type] = type.to_s
      payload[:id] = id unless id.nil?
      payload[:ref] = ref unless ref.nil?
      unless description.nil? && currency.nil? && price.nil? && show_button.nil? && button_text.nil?
        payload[:properties] = {}
        payload[:properties][:description] = description unless description.nil?
        payload[:properties][:currency] = currency unless currency.nil?
        payload[:properties][:price] = price unless price.nil?
        payload[:properties][:show_button] = show_button unless show_button.nil?
        payload[:properties][:button_text] = button_text unless button_text.nil?
      end
      unless required.nil?
        payload[:validations] = {}
        payload[:validations][:required] = required
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same_extra_attributes?(actual)
      (required.nil? ? PaymentBlock.default.required : required) == actual.required &&
        (price.nil? ? PaymentBlock.default.price : price) == actual.price &&
        (currency.nil? ? PaymentBlock.default.currency : currency) == actual.currency &&
        (show_button.nil? || show_button == actual.show_button) &&
        (button_text.nil? || button_text == actual.button_text)
    end

    def self.default
      PaymentBlock.new(
        required: false,
        price: { type: 'variable', value: 'price' },
        currency: 'EUR'
      )
    end

    def self.full_example(id: nil)
      PaymentBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        id: id,
        required: true,
        currency: 'USD',
        price: { type: 'variable', value: 'price' },
        show_button: true, button_text: 'Click me!',
        attachment: Block.attachment
      )
    end
  end
end
