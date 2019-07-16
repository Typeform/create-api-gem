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

require 'minitest/autorun'
require 'create_api_gem'

module Typeform
  class TeamsTest < TestBase
    def test_all_requests
      retrieve_team = RetrieveTeamRequest.new
      assert retrieve_team.success?, true

      default_workspace = RetrieveAllWorkspacesRequest.execute.default_workspace
      UpdateWorkspaceRequest.execute(default_workspace, [PatchOperation.new(op: 'add', path: '/members', value: { email: email })])

      update_team = UpdateTeamRequest.new([PatchOperation.new(op: 'remove', path: '/members', value: { email: email })])
      assert update_team.success?, true
    end
  end
end
