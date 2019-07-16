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
  class Notifications
    attr_accessor :self_enabled, :self_recipients, :self_reply_to, :self_subject, :self_message,
                  :respondent_enabled, :respondent_recipient, :respondent_reply_to, :respondent_subject, :respondent_message

    def initialize(self_enabled: nil, self_recipients: nil, self_reply_to: nil, self_subject: nil, self_message: nil,
                  respondent_enabled: nil, respondent_recipient: nil, respondent_reply_to: nil, respondent_subject: nil, respondent_message: nil)
      @self_enabled = self_enabled
      @self_recipients = self_recipients
      @self_reply_to = self_reply_to
      @self_subject = self_subject
      @self_message = self_message
      @respondent_enabled = respondent_enabled
      @respondent_recipient = respondent_recipient
      @respondent_reply_to = respondent_reply_to
      @respondent_subject = respondent_subject
      @respondent_message = respondent_message
    end

    def self.from_response(response)
      self_payload = response[:self]
      new_self_payload = {}
      if self_payload
        self_payload.each_key do |key|
          new_key = 'self_' + key.to_s
          new_self_payload[new_key.to_sym] = self_payload.delete(key)
        end
      end

      respondent_payload = response[:respondent]
      new_respondent_payload = {}
      if respondent_payload
        respondent_payload.each_key do |key|
          new_key = 'respondent_' + key.to_s
          new_respondent_payload[new_key.to_sym] = respondent_payload.delete(key)
        end
      end

      params = new_respondent_payload.merge(new_self_payload)
      Notifications.new(params)
    end

    def payload
      payload = {}
      unless self_recipients.nil? && self_subject.nil? && self_message.nil?
        payload[:self] = {}
        payload[:self][:enabled] = self_enabled unless self_enabled.nil?
        payload[:self][:reply_to] = self_reply_to unless self_reply_to.nil?
        payload[:self][:recipients] = self_recipients unless self_recipients.nil?
        payload[:self][:subject] = self_subject unless self_subject.nil?
        payload[:self][:message] = self_message unless self_message.nil?
      end
      unless respondent_recipient.nil? && respondent_subject.nil? && respondent_message.nil?
        payload[:respondent] = {}
        payload[:respondent][:enabled] = respondent_enabled unless respondent_enabled.nil?
        payload[:respondent][:reply_to] = respondent_reply_to unless respondent_reply_to.nil?
        payload[:respondent][:recipient] = respondent_recipient unless respondent_recipient.nil?
        payload[:respondent][:subject] = respondent_subject unless respondent_subject.nil?
        payload[:respondent][:message] = respondent_message unless respondent_message.nil?
      end
      payload
    end

    def same?(actual)
      (self_enabled.nil? || self_enabled == actual.self_enabled) &&
        (self_reply_to.nil? || self_reply_to == actual.self_reply_to) &&
        (self_recipients.nil? || self_recipients == actual.self_recipients) &&
        (self_subject.nil? || self_subject == actual.self_subject) &&
        (self_message.nil? || self_message == actual.self_message) &&
        (respondent_enabled.nil? || respondent_enabled == actual.respondent_enabled) &&
        (respondent_reply_to.nil? || respondent_reply_to == actual.respondent_reply_to) &&
        (respondent_recipient.nil? || respondent_recipient == actual.respondent_recipient) &&
        (respondent_subject.nil? || respondent_subject == actual.respondent_subject) &&
        (respondent_message.nil? || respondent_message == actual.respondent_message)
    end

    def self.full_example(email_block_for_notifications_ref)
      Notifications.new(self_enabled: true, self_reply_to: '{{field:' + email_block_for_notifications_ref + '}}', self_recipients: ['recipient1@email.com', 'recipient2@email.com'],
                        self_subject: 'An email subject', self_message: 'This is a message that will be in an email',
                        respondent_enabled: true, respondent_reply_to: ['hello@email.com'], respondent_recipient: '{{field:' + email_block_for_notifications_ref + '}}',
                        respondent_subject: 'An email subject', respondent_message: 'This is a message that will be in an email')
    end
  end
end
