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
  class Settings
    attr_accessor :redirect_after_submit_url, :show_typeform_branding, :progress_bar,
                  :show_progress_bar, :description, :allow_indexing, :image, :language,
                  :is_public, :is_trial, :google_analytics, :facebook_pixel, :google_tag_manager,
                  :notifications

    def initialize(redirect_after_submit_url: nil, show_typeform_branding: nil, progress_bar: nil,
                  show_progress_bar: nil, description: nil, allow_indexing: nil, image: nil, language: nil,
                  is_public: nil, is_trial: nil, google_analytics: nil, facebook_pixel: nil,
                  google_tag_manager: nil, notifications: nil)

      @redirect_after_submit_url = redirect_after_submit_url
      @show_typeform_branding = show_typeform_branding
      @progress_bar = progress_bar
      @show_progress_bar = show_progress_bar
      @description = description
      @allow_indexing = allow_indexing
      @language = language
      @is_public = is_public
      @is_trial = is_trial
      @image = image
      @google_analytics = google_analytics
      @facebook_pixel = facebook_pixel
      @google_tag_manager = google_tag_manager
      @notifications = notifications
    end

    def self.from_response(response)
      meta = response[:meta]
      settings_params = response.keep_if { |k, _| k != :meta }
      params = meta.merge(settings_params)
      params[:notifications] = Notifications.from_response(response[:notifications]) unless response[:notifications].nil?
      Settings.new(params)
    end

    def payload
      payload = {}
      payload[:redirect_after_submit_url] = redirect_after_submit_url unless redirect_after_submit_url.nil?
      payload[:show_typeform_branding] = show_typeform_branding unless show_typeform_branding.nil?
      payload[:progress_bar] = progress_bar unless progress_bar.nil?
      payload[:show_progress_bar] = show_progress_bar unless show_progress_bar.nil?
      payload[:language] = language unless language.nil?
      payload[:is_public] = is_public unless is_public.nil?
      payload[:google_analytics] = google_analytics unless google_analytics.nil?
      payload[:facebook_pixel] = facebook_pixel unless facebook_pixel.nil?
      payload[:google_tag_manager] = google_tag_manager unless google_tag_manager.nil?
      payload[:notifications] = notifications.payload unless notifications.nil?
      unless description.nil? && allow_indexing.nil?
        payload[:meta] = {}
        payload[:meta][:description] = description unless description.nil?
        payload[:meta][:allow_indexing] = allow_indexing unless allow_indexing.nil?
        payload[:meta][:image] = image unless image.nil?
      end
      payload
    end

    def same?(actual)
      (redirect_after_submit_url.nil? || redirect_after_submit_url == actual.redirect_after_submit_url) &&
        (google_analytics.nil? || google_analytics == actual.google_analytics) &&
        (facebook_pixel.nil? || facebook_pixel == actual.facebook_pixel) &&
        (google_tag_manager.nil? || google_tag_manager == actual.google_tag_manager) &&
        (notifications.nil? || notifications.same?(actual.notifications)) &&
        (description.nil? || description == actual.description) &&
        (show_typeform_branding.nil? ? Settings.default.show_typeform_branding : show_typeform_branding) == actual.show_typeform_branding &&
        (progress_bar.nil? ? Settings.default.progress_bar : progress_bar) == actual.progress_bar &&
        (language.nil? ? Settings.default.language : language) == actual.language &&
        (is_public.nil? ? Settings.default.is_public : is_public) == actual.is_public &&
        (allow_indexing.nil? ? Settings.default.allow_indexing : allow_indexing) == actual.allow_indexing &&
        same_image?(actual)
    end

    def same_image?(actual)
      image.nil? || image[:href].start_with?("#{APIConfig.image_api_request_url}/images/") && actual.image[:href].start_with?("#{APIConfig.image_api_request_url}/images/")
    end

    def self.default
      Settings.new(show_typeform_branding: true, progress_bar: 'proportion', show_progress_bar: true,
                  allow_indexing: false, language: 'en', is_public: true, is_trial: false)
    end

    def self.full_example(email_block_for_notifications_ref)
      image = { href: APIConfig.image_api_request_url + '/images/default' }
      Settings.new(redirect_after_submit_url: 'http://google.com', show_typeform_branding: false, progress_bar: 'percentage',
                  show_progress_bar: false, description: 'some meta description', allow_indexing: true, image: image,
                  language: 'fr', is_public: true, google_analytics: 'UA-1234-12', facebook_pixel: '12345678901234567',
                  google_tag_manager: 'GTM-PLWP6TS', notifications: Notifications.full_example(email_block_for_notifications_ref))
    end
  end
end
