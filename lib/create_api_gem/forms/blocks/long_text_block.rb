require_relative 'block'

class LongTextBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required, :max_length, :attachment

  def initialize(id: nil, title: nil, type: :long_text, ref: nil, description: nil, required: nil,
                 max_length: nil, attachment: nil)
    @id = id
    @title = title || DataGenerator.title
    @type = type
    @ref = ref
    @description = description
    @required = required
    @max_length = max_length
    @attachment = attachment
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:id] = id unless id.nil?
    payload[:ref] = ref unless ref.nil?
    unless description.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description
    end
    unless required.nil? && max_length.nil?
      payload[:validations] = {}
      payload[:validations][:required] = required unless required.nil?
      payload[:validations][:max_length] = max_length unless max_length.nil?
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (max_length.nil? || max_length == actual.max_length) &&
      (required.nil? ? LongTextBlock.default.required : required) == actual.required &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    LongTextBlock.new(
      required: false
    )
  end

  def self.full_example(id: nil)
    LongTextBlock.new(
      ref: Block.ref,
      description: DataGenerator.description,
      id: id,
      required: true,
      max_length: 500,
      attachment: Block.attachment
    )
  end
end
