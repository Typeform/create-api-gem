class FieldLogic
  attr_accessor :field_ref, :type, :actions

  def initialize(field_ref: nil, type: nil, actions: [])
    @field_ref = field_ref
    @actions = actions
    @type = type
  end

  def self.from_response(payload)
    field_ref = payload[:ref] unless payload[:ref].nil?
    actions = payload[:actions].nil? ? [] : payload[:actions].map { |action_payload| LogicAction.from_response(action_payload) }
    type = payload[:type]
    FieldLogic.new(field_ref: field_ref, type: type, actions: actions)
  end

  def payload
    payload = {}
    payload[:ref] = field_ref unless field_ref.nil?
    payload[:type] = type unless type.nil?
    payload[:actions] = actions.map(&:payload) unless actions.empty?
    payload
  end

  def same?(actual)
    (field_ref.nil? || field_ref == actual.field_ref) &&
      type == actual.type &&
      actions.zip(actual.actions).all? do |expected_action, actual_action|
        expected_action.same?(actual_action)
      end && actions.length == actual.actions.length
  end
end
