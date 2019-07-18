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

require_relative '../../api_request'

module Typeform
  class ThemeRequest < APIRequest
    def location_header
      headers.fetch(:location)
    end

    def theme
      Theme.from_response(json)
    end

    def invalid_theme?
      @response.code == 400
    end

    def not_found_theme?
      @response.code == 404
    end

    def forbidden?
      @response.code == 403
    end

    def theme_id
      headers.fetch(:location).split('/themes/')[1]
    end
  end
end
