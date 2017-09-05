class LegalBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required

  def initialize(id: nil, title: nil, type: :legal, ref: nil, description: nil, required: nil)
    super
    @id = id
    @title = title
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
    (required.nil? ? LegalBlock.default.required : required) == actual.required
  end

  def self.default
    LegalBlock.new(
        title: 'A legal block ref',
        required: false
    )
  end

  def self.full_example(id: nil)
    LegalBlock.new(
        title: 'A legal block ref',
        ref: Block.ref,
        description: 'a description of the legal block',
        required: true,
        id: id
    )
  end
end
