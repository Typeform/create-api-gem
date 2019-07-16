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
  class ThankYouScreen < Block
    attr_accessor :title, :ref, :show_button, :button_text, :button_mode, :redirect_url, :share_icons, :attachment

    def initialize(title: nil, ref: nil, show_button: nil, button_text: nil, button_mode: nil, redirect_url: nil, share_icons: nil, attachment: nil)
      @title = title || DataGenerator.title
      @ref = ref
      @show_button = show_button
      @button_text = button_text
      @button_mode = button_mode
      @redirect_url = redirect_url
      @share_icons = share_icons
      @attachment = attachment
    end

    def self.from_response(response)
      properties = response[:properties]
      block_params = response.keep_if { |k, _| k != :properties }
      params = properties.merge(block_params)
      ThankYouScreen.new(params)
    end

    def payload
      payload = {}

      payload[:title] = title
      payload[:ref] = ref unless ref.nil?
      unless show_button.nil? && button_text.nil? && button_mode.nil? && redirect_url.nil? && share_icons.nil?
        payload[:properties] = {}
        payload[:properties][:show_button] = show_button unless show_button.nil?
        payload[:properties][:button_text] = button_text unless button_text.nil?
        payload[:properties][:button_mode] = button_mode unless button_mode.nil?
        payload[:properties][:redirect_url] = redirect_url unless redirect_url.nil?
        payload[:properties][:share_icons] = share_icons unless share_icons.nil?
      end
      payload[:attachment] = attachment unless attachment.nil?
      payload
    end

    def same?(actual)
      title == actual.title &&
        (ref.nil? || ref == actual.ref) &&
        (show_button.nil? ? ThankYouScreen.default.show_button == actual.show_button : show_button == actual.show_button) &&
        (button_text.nil? || button_text == actual.button_text) &&
        ((button_mode.nil? ? ThankYouScreen.default.button_mode == actual.button_mode : button_mode == actual.button_mode) || ref == 'default_tys') &&
        (redirect_url.nil? || (redirect_url == actual.redirect_url && ref != 'default_tys') || (redirect_url.include?(actual.redirect_url) || ref == 'default_tys')) &&
        (share_icons.nil? ? ThankYouScreen.default.share_icons == actual.share_icons : share_icons == actual.share_icons) &&
        (attachment.nil? || same_attachment?(actual.attachment) || ref == 'default_tys')
    end

    def self.default
      ThankYouScreen.new(
        show_button: true,
        button_mode: 'reload',
        share_icons: true
      )
    end

    def self.default_basic(account_id: nil, form_uid: nil)
      ThankYouScreen.new(
        title: "Thanks for completing this typeform\nNow *create your own* — it's free, easy, & beautiful",
        ref: 'default_tys',
        show_button: true,
        share_icons: false,
        button_mode: 'redirect',
        button_text: 'Create a *typeform*',
        redirect_url: "/signup?utm_campaign=#{form_uid}&utm_source=typeform.com-#{account_id}-Basic&utm_medium=typeform&utm_content=typeform-thankyoubutton&utm_term=EN",
        attachment: {
          type: 'image',
          href: "#{APIConfig.image_api_request_url}/images/2dpnUBBkz2VN"
        }
      )
    end

    def self.default_pro
      ThankYouScreen.new(
        title: 'Done! Your information was sent perfectly.',
        ref: 'default_tys',
        show_button: false,
        share_icons: false
      )
    end

    def self.full_example
      ThankYouScreen.new(
        ref: DataGenerator.field_ref,
        show_button: false,
        button_text: 'Click me!',
        button_mode: 'redirect',
        redirect_url: 'http://www.google.com',
        share_icons: false,
        attachment: Block.attachment
      )
    end
  end
end