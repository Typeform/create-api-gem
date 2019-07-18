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

require_relative 'workspace_request'
require 'open-uri'

module Typeform
  class RetrieveAllWorkspacesRequest < WorkspaceRequest
    def initialize(token: APIConfig.token, workspaces_per_page: 10, page: nil, search: nil)
      url = "#{APIConfig.workspaces_api_request_url}?"
      url << "page_size=#{workspaces_per_page}&" unless workspaces_per_page.nil?
      url << "page=#{page}&" unless page.nil?
      url << "search=#{URI.encode_www_form_component(search)}&" unless search.nil?
      request(
        method: :get,
        url: url,
        headers: {
          'Authorization' => "Bearer #{token}"
        }
      )
    end

    def success?
      @response.code == 200 && json?
    end

    def workspaces
      json.fetch(:items).map do |workspace_json|
        Workspace.from_response(workspace_json)
      end
    end

    def default_workspace
      workspaces.find(&:default)
    end
  end
end
