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

require_relative 'theme_request'
require 'rack'

module Typeform
  class RetrieveAllThemesRequest < APIRequest
    def initialize(token: APIConfig.token, page: nil, page_size: nil, visibility: nil)
      filters = {}
      filters[:page] = page unless page.nil?
      filters[:page_size] = page_size unless page_size.nil?
      filters[:visibility] = visibility unless visibility.nil?
      parameters = Rack::Utils.build_query(filters)
      request(
        method: :get,
        url: "#{APIConfig.api_request_url}/themes?" + parameters,
        headers: {
          'Authorization' => "Bearer #{token}"
        },
        verify_ssl: OpenSSL::SSL::VERIFY_NONE
      )
    end

    def bad_request?
      @response.code == 400 && json?
    end

    def success?
      @response.code == 200 && json?
    end

    def themes
      json.fetch(:items)
    end

    def total_items
      json.fetch(:total_items)
    end

    def page_count
      json.fetch(:page_count)
    end
  end
end
