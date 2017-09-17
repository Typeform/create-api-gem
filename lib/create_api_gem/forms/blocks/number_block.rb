require_relative 'block'

class NumberBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required, :min_value, :max_value, :attachment

  def initialize(id: nil, title: nil, type: :number, ref: nil, description: nil, required: nil, min_value: nil,
                 max_value: nil, attachment: nil)
    @id = id
    @title = title || DataGenerator.title
    @type = type
    @ref = ref
    @description = description
    @required = required
    @min_value = min_value
    @max_value = max_value
    @attachment = attachment
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:ref] = ref unless ref.nil?
    payload[:id] = id unless id.nil?
    unless description.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description
    end
    unless required.nil? && min_value.nil? && max_value.nil?
      payload[:validations] = {}
      payload[:validations][:required] = required unless required.nil?
      payload[:validations][:min_value] = min_value unless min_value.nil?
      payload[:validations][:max_value] = max_value unless max_value.nil?
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (min_value.nil? || min_value == actual.min_value) &&
      (max_value.nil? || max_value == actual.max_value) &&
      (required.nil? ? NumberBlock.default.required : required) == actual.required &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    NumberBlock.new(
        required: false
    )
  end

  def self.full_example(id: nil)
    NumberBlock.new(
        ref: Block.ref,
        description: DataGenerator.description,
        id: id,
        required: true,
        min_value: 1,
        max_value: 500,
        attachment: Block.attachment
    )
  end
end
