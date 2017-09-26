class PatchTeamOperation
  attr_accessor :op, :value, :path

  def initialize(op: nil, path: nil, value: nil)
    @op = op
    @path = path
    @value = value
  end

  def payload
    {
      op: op,
      path: path,
      value: { email: value }
    }
  end
end
