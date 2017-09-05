class RatingBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :steps, :shape, :required, :attachment

  def initialize(id: nil, title:, type: :rating, ref: nil, description: nil, steps: nil, shape: nil,
                 required: nil, attachment: nil)
    super
    @id = id
    @title = title
    @type = type
    @ref = ref
    @description = description
    @steps = steps
    @shape = shape
    @required = required
    @attachment = attachment
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:ref] = ref unless ref.nil?
    payload[:id] = id unless id.nil?
    unless description.nil? && steps.nil? && shape.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description unless description.nil?
      payload[:properties][:steps] = steps unless steps.nil?
      payload[:properties][:shape] = shape unless shape.nil?
    end
    unless required.nil?
      payload[:validations] = {}
      payload[:validations][:required] = required unless required.nil?
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (steps.nil? ? RatingBlock.default.steps : steps) == actual.steps &&
      (shape.nil? ? RatingBlock.default.shape : shape) == actual.shape &&
      (required.nil? ? RatingBlock.default.required : required) == actual.required &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    RatingBlock.new(
        steps: 3,
        shape: 'star',
        required: false
    )
  end

  def self.full_example(id: nil)
    RatingBlock.new(
        title: 'A rating block',
        ref: Block.ref,
        description: 'a description of the rating block',
        steps: 8,
        shape: 'heart',
        id: id,
        required: true,
        attachment: Block.attachment
    )
  end
end
