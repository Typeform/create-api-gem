require_relative 'block'

class YesNoBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required, :attachment

  def initialize(id: nil, title:, type: :yes_no, ref: nil, description: nil, required: nil, attachment: nil)
    super
    @id = id
    @title = title
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
    (required.nil? ? YesNoBlock.default.required : required) == actual.required &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    YesNoBlock.new(
        required: false
    )
  end

  def self.full_example(id: nil)
    YesNoBlock.new(
        title: 'A yes no block',
        ref: Block.ref,
        description: 'a description of the yes no block',
        required: true,
        attachment: Block.attachment,
        id: id
    )
  end
end
