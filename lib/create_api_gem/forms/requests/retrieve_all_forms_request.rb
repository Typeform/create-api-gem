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

require_relative 'form_request'
require 'open-uri'

class RetrieveAllFormsRequest < FormRequest
  def initialize(token: APIConfig.token, forms_per_page: 10, page: nil, search: nil)
    url = "#{APIConfig.api_request_url}/forms?"
    unless forms_per_page.nil?
      url << "page_size=#{forms_per_page}&"
    end
    unless page.nil?
      url << "page=#{page}&"
    end
    unless search.nil?
      url << "search=#{URI::encode(search)}&"
    end
    r = {
      method: :get,
      url: url
    }
    r[:headers] = { 'Authorization' => "Bearer #{token}" } unless token.nil?

    request(r)
  end

  def success?
    @response.code == 200 && json?
  end

  def forms
    json.fetch(:items)
  end
end
