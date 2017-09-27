class Workspace
  attr_accessor :name, :id, :default, :shared, :members

  def initialize(name: nil, id: nil, default: nil, shared: nil, members: nil)
    @name = name || DataGenerator.title
    @id = id
    @default = default
    @shared = shared
    @members = members
  end

  def payload
    {
      name: name
    }.to_json
  end

  def same?(actual)
    name == actual.name &&
      id.nil? || id == actual.id &&
        (default.nil? ? default.default : default) == actual.default &&
        (shared.nil? ? default.shared : shared) == actual.shared
  end

  def self.default
    Workspace.new(default: false, shared: false)
  end

  def self.from_response(payload)
    new(
      name: payload[:name],
      id: payload[:id],
      default: payload[:default],
      shared: payload[:shared],
      members: payload[:members]
    )
  end
end
