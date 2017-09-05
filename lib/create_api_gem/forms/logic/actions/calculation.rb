require_relative '../logic_action'

class Calculation < LogicAction
  attr_accessor :action_type, :numeric_value, :target_ref, :logic_condition

  def initialize(action_type: nil, numeric_value: nil, target_ref: nil, logic_condition: nil)
    @action_type = action_type
    @numeric_value = numeric_value
    @target_ref = target_ref
    @logic_condition = logic_condition
  end

  def self.from_response(payload)
    action_type = payload[:action]
    target_ref = payload[:details][:target][:value]
    numeric_value = payload[:details][:value][:value]
    logic_condition = LogicCondition.from_response(payload[:condition])
    Calculation.new(action_type: action_type, numeric_value: numeric_value, target_ref: target_ref, logic_condition: logic_condition)
  end

  def payload
    payload = {}
    payload[:action] = action_type
    payload[:details] = { target: { type: 'variable', value: target_ref } }
    payload[:details][:value] = { type: 'constant', value: numeric_value }
    payload[:condition] = logic_condition.to_payload
    payload
  end

  def same?(actual)
    action_type == actual.action_type &&
      target_ref == actual.target_ref &&
      numeric_value == actual.numeric_value &&
      logic_condition.same?(actual.logic_condition)
  end
end
