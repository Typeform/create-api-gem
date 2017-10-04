require 'minitest/autorun'
require 'create_api_gem'

class TeamsTest < TestBase
  def test_all_requests
    retrieve_team = RetrieveTeamRequest.new
    assert retrieve_team.success?, true

    default_workspace = RetrieveAllWorkspacesRequest.execute.default_workspace
    UpdateWorkspaceRequest.execute(default_workspace, [PatchWorkspaceOperation.new(op: 'add', path: '/members', value: email)])

    update_team = UpdateTeamRequest.new([PatchTeamOperation.new(op: 'remove', path: '/members', value: email)])
    assert update_team.success?, true
  end
end
