require 'minitest/autorun'
require 'create_api_gem'

class WorkspacesTest < TestBase
  def test_crud_operations
    retrieve_team = RetreiveTeamRequest.new(token)
    assert retrieve_team.success?, true

    default_workspace = RetrieveAllWorkspacesRequest.execute(token).default_workspace
    email = 'maria_jose@typeform.com'
    PatchWorkspaceRequest.execute(token, default_workspace, [PatchWorkspaceOperation.new(op: 'add', path: '/members', value: email)])

    update_team = UpdateTeamRequest.new(token, [PatchTeamOperation.new(op: 'remove', path: '/members', value: email)])
    assert update_team.success?, true
  end
end
