class PatchWorkspaceOperation
  attr_accessor :op, :value, :path

  def initialize(op: nil, path: nil, value: nil)
    @op = op
    @path = path
    @value = value || DataGenerator.title
  end

  def payload
    case path
    when '/forms'
      {
        op: op,
        path: path,
        value: { href: "#{APIConfig.api_request_url}/forms/#{value}" }
      }
    when '/members'
      {
        op: op,
        path: path,
        value: { email: value }
      }
    else
      {
        op: op,
        path: path,
        value: value
      }
    end
  end
end
