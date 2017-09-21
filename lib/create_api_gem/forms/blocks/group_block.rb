require_relative 'block'

class GroupBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :show_button, :button_text, :attachment, :fields

  def initialize(id: nil, title: nil, type: :group, ref: nil, description: nil, show_button: nil, button_text: nil, attachment: nil, fields: [])
    @id = id
    @title = title || DataGenerator.title
    @type = type
    @ref = ref
    @description = description
    @show_button = show_button
    @button_text = button_text
    @attachment = attachment
    @fields = fields
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:id] = id unless id.nil?
    payload[:ref] = ref unless ref.nil?
    unless description.nil? && fields.nil? && show_button.nil? && button_text.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description unless description.nil?
      payload[:properties][:show_button] = show_button unless show_button.nil?
      payload[:properties][:button_text] = button_text unless button_text.nil?
      unless fields.nil?
        p = []
        fields.each { |field| p << field.payload unless field.nil? }
        payload[:properties][:fields] = p
      end
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    same_fields?(actual.fields) &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def same_fields?(actual_fields)
    fields.zip(actual_fields).all? do |expected, actual|
      expected.same?(actual)
    end && fields.length == actual_fields.length
  end

  def self.default
    GroupBlock.new(
      fields: [],
      button_text: 'Continue',
      show_button: false
    )
  end

  def self.full_example(id: nil, blocks: nil)
    fields = blocks.nil? ?
      Block.all_types.values.map do |block|
        block.full_example unless block == GroupBlock || block == PaymentBlock
      end
      :
      blocks.map do |block|
        block.class.full_example(id: block.id) unless block == GroupBlock || block == PaymentBlock
      end

    GroupBlock.new(
      ref: Block.ref,
      id: id,
      description: DataGenerator.description,
      button_text: 'Click me!',
      show_button: true,
      fields: fields.compact,
      attachment: Block.attachment
    )
  end
end
