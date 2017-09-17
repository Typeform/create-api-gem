class PatchOperation
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
      }.to_json
    when '/members'
      {
        op: op,
        path: path,
        value: { email: value }
      }.to_json
    else
      {
        op: op,
        path: path,
        value: value
      }.to_json
    end
  end
end
