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

class WorkspacesTest < TestBase
  def test_all_requests
    workspace = Workspace.new

    create_workspace = CreateWorkspaceRequest.new(workspace)
    assert_equal create_workspace.success?, true
    assert_equal workspace.same?(create_workspace.workspace), true
    workspace = create_workspace.workspace

    retrieve_workspace = RetrieveWorkspaceRequest.new(workspace)
    assert_equal retrieve_workspace.success?, true
    assert_equal workspace.same?(retrieve_workspace.workspace), true
    workspace = retrieve_workspace.workspace

    retrieve_all_workspaces = RetrieveAllWorkspacesRequest.new
    assert_equal retrieve_all_workspaces.success?, true
    default_workspace = retrieve_all_workspaces.default_workspace

    retrieve_workspace_forms = RetrieveWorkspaceFormsRequest.new(default_workspace)
    assert_equal retrieve_workspace_forms.success?, true

    form = CreateFormRequest.execute(Form.new).form
    operations = [
      PatchWorkspaceOperation.new(op: 'replace', path: '/name', value: DataGenerator.title),
      PatchWorkspaceOperation.new(op: 'add', path: '/forms', value: form.id),
      PatchWorkspaceOperation.new(op: 'add', path: '/members', value: email)
    ]
    update_workspace = UpdateWorkspaceRequest.new(workspace, operations)
    assert_equal update_workspace.success?, true

    UpdateWorkspaceRequest.execute(workspace, [PatchWorkspaceOperation.new(op: 'remove', path: '/members', value: email)])
    UpdateWorkspaceRequest.execute(default_workspace, [PatchWorkspaceOperation.new(op: 'add', path: '/forms', value: form.id)])
    DeleteFormRequest.execute(form)

    delete_workspace = DeleteWorkspaceRequest.new(workspace)
    assert_equal delete_workspace.success?, true
  end

  def test_same_method
    workspace = Workspace.new
    same_workspace = workspace.dup
    assert_equal workspace.same?(same_workspace), true

    different_workspace = workspace.dup
    different_workspace.name = DataGenerator.title
    assert_equal workspace.same?(different_workspace), false
  end
end
