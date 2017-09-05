class StatementBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :hide_marks, :button_text, :attachment

  def initialize(id: nil, title: nil, type: :statement, ref: nil, description: nil, hide_marks: nil,
                 button_text: nil, attachment: nil)
    @id = id
    @title = title || Fake.title
    @type = type
    @ref = ref
    @description = description
    @hide_marks = hide_marks
    @button_text = button_text
    @attachment = attachment
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:id] = id unless id.nil?
    payload[:ref] = ref unless ref.nil?
    unless description.nil? && hide_marks.nil? && button_text.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description unless description.nil?
      payload[:properties][:hide_marks] = hide_marks unless hide_marks.nil?
      payload[:properties][:button_text] = button_text unless button_text.nil?
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (hide_marks.nil? ? StatementBlock.default.hide_marks : hide_marks) == actual.hide_marks &&
      (button_text.nil? ? StatementBlock.default.button_text : button_text) == actual.button_text &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    StatementBlock.new(button_text: 'Continue', hide_marks: false)
  end

  def self.full_example(id: nil)
    StatementBlock.new(
        title: 'A statement block',
        ref: Block.ref,
        description: 'a description of the statement block',
        hide_marks: true,
        id: id,
        button_text: 'Click me!',
        attachment: Block.attachment
    )
  end
end
