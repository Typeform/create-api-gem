require_relative 'workspace_request'

class CreateWorkspaceRequest < WorkspaceRequest
  def initialize(token = APIConfig.token, workspace)
    request(
      method: :post,
      url: "#{APIConfig.api_request_url}/workspaces",
      headers: {
        'Authorization' => "Bearer #{token}"
      },
      payload: workspace.payload
    )
  end

  def success?
    @response.code == 201 && json? && json.key?(:forms) && json.key?(:self)
  end
end
