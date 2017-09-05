class LogicConditionDetails
  attr_accessor :reference_type, :reference, :value_type, :value

  def initialize(reference_type: nil, reference: nil, value_type: nil, value: nil)
    @reference_type = reference_type
    @reference = reference
    @value_type = value_type
    @value = value
  end

  def self.from_response(payload)
    reference_object = payload.first
    value_object = payload.last
    LogicConditionDetails.new(reference_type: reference_object[:type], reference: reference_object[:value], value_type: value_object[:type], value: value_object[:value])
  end

  def payload
    [{ type: reference_type, value: reference }, { type: value_type, value: value }]
  end

  def same?(actual)
    reference_type == actual.reference_type &&
      reference == actual.reference &&
      value_type == actual.value_type &&
      value == actual.value
  end
end
