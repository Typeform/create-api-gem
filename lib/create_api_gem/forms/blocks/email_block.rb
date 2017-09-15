require_relative 'block'

class EmailBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required, :attachment

  def initialize(id: nil, title:, type: :email, ref: nil, description: nil, required: nil, attachment: nil)
    @id = id
    @title = title || Fake.title
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
        title: 'Email block',
        required: false
    )
  end

  def self.full_example(id: nil)
    EmailBlock.new(
        title: 'A email block',
        ref: Block.ref,
        description: 'a description of the email block',
        id: id,
        required: true,
        attachment: Block.attachment
    )
  end
end
