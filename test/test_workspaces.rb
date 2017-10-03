require 'minitest/autorun'
require 'create_api_gem'

class WorkspacesTest < TestBase
  def test_all_requests
    workspace = Workspace.new

    create_workspace = CreateWorkspaceRequest.new(token, workspace)
    assert_equal create_workspace.success?, true
    assert_equal workspace.same?(create_workspace.workspace), true
    workspace = create_workspace.workspace

    retrieve_workspace = RetrieveWorkspaceRequest.new(token, workspace)
    assert_equal retrieve_workspace.success?, true
    assert_equal workspace.same?(retrieve_workspace.workspace), true
    workspace = retrieve_workspace.workspace

    retrieve_all_workspaces = RetrieveAllWorkspacesRequest.new(token)
    assert_equal retrieve_all_workspaces.success?, true
    default_workspace = retrieve_all_workspaces.default_workspace

    retrieve_workspace_forms = RetrieveWorkspaceFormsRequest.new(token, default_workspace)
    assert_equal retrieve_workspace_forms.success?, true

    form = CreateFormRequest.execute(token, Form.new).form
    operations = [
      PatchWorkspaceOperation.new(op: 'replace', path: '/name', value: DataGenerator.title),
      PatchWorkspaceOperation.new(op: 'add', path: '/forms', value: form.id),
      PatchWorkspaceOperation.new(op: 'add', path: '/members', value: email)
    ]
    update_workspace = UpdateWorkspaceRequest.new(token, workspace, operations)
    assert_equal update_workspace.success?, true

    UpdateWorkspaceRequest.execute(token, workspace, [PatchWorkspaceOperation.new(op: 'remove', path: '/members', value: email)])
    UpdateWorkspaceRequest.execute(token, default_workspace, [PatchWorkspaceOperation.new(op: 'add', path: '/forms', value: form.id)])
    DeleteFormRequest.execute(token, form)

    delete_workspace = DeleteWorkspaceRequest.new(token, workspace)
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
