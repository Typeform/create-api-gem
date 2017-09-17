require_relative 'block'

class WebsiteBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required

  def initialize(id: nil, title: nil, type: :website, ref: nil, description: nil, required: nil)
    @id = id
    @title = title || DataGenerator.title
    @type = type
    @ref = ref
    @description = description
    @required = required
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
    payload
  end

  def same_extra_attributes?(actual)
    (required.nil? ? WebsiteBlock.default.required : required) == actual.required
  end

  def self.default
    WebsiteBlock.new(
        required: false
    )
  end

  def self.full_example(id: nil)
    WebsiteBlock.new(
        ref: Block.ref,
        description: DataGenerator.description,
        required: true,
        id: id
    )
  end
end
