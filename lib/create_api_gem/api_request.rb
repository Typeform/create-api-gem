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
  class APIRequest
    def self.execute(*args)
      new(*args).tap do |request|
        raise StandardError, "Failed asserting that the request succeeds\n\n#{request.inspect}" unless request.success?
      end
    end

    def headers
      @response.headers
    end

    def inspect
      "#{@response.code}\n#{@response}"
    end

    def bad_request?
      @response.code == 400
    end

    def unauthorized?
      @response.code == 401
    end

    def payment_required?
      @response.code == 402
    end

    def forbidden?
      @response.code == 403
    end

    def not_found?
      @response.code == 404
    end

    def service_unavailable?
      @response.code == 502 || @response.code == 503
    end

    def error_code
      json.fetch(:code)
    end

    private

    def request(args = {})
      RestClient::Request.execute(args) { |r| @response = r }
    end

    def json
      JSON.parse(@response, symbolize_names: true)
    end

    def json?
      json
      true
    rescue JSON::ParserError
      false
    end
  end
end
