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

module Typeform
  class UpdateThemeRequest < ThemeRequest
    def initialize(theme, token: APIConfig.token)
      request(
        method: :put,
        url: "#{APIConfig.api_request_url}/themes/#{theme.id}",
        headers: {
          'Authorization' => "Bearer #{token}",
          'Content-Type' => 'application/json'
        },
        payload: theme.payload
      )
    end

    def success?
      @response.code == 200 && json?
    end
  end
end
