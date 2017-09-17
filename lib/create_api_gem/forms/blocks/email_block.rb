require_relative 'block'

class EmailBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required, :attachment

  def initialize(id: nil, title: nil, type: :email, ref: nil, description: nil, required: nil, attachment: nil)
    @id = id
    @title = title || DataGenerator.title
    @type = type
    @ref = ref
    @description = description
    @required = required
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
    unless required.nil?
      payload[:validations] = {}
      payload[:validations][:required] = required
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (required.nil? ? EmailBlock.default.required : required) == actual.required &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    EmailBlock.new(
      required: false
    )
  end

  def self.full_example(id: nil)
    EmailBlock.new(
      ref: Block.ref,
      description: DataGenerator.description,
      id: id,
      required: true,
      attachment: Block.attachment
    )
  end
end
