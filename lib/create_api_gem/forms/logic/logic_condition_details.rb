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
    reference_type = reference_object[:type] unless reference_object.nil?
    reference = reference_object[:value] unless reference_object.nil?
    value_type = value_object[:type] unless value_object.nil?
    value = value_object[:value] unless value_object.nil?
    LogicConditionDetails.new(
      reference_type: reference_type,
      reference: reference,
      value_type: value_type,
      value: value)
  end

  def payload
    if reference_type.nil?
      []
    else
      [{ type: reference_type, value: reference }, { type: value_type, value: value }]
    end
  end

  def same?(actual)
    reference_type == actual.reference_type &&
      reference == actual.reference &&
      value_type == actual.value_type &&
      value == actual.value
  end
end
