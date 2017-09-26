class WelcomeScreen < Block
  attr_accessor :id, :title, :ref, :type, :description, :show_button, :button_text, :attachment

  def initialize(id: nil, title: nil, type: :welcome_screen, ref: nil, description: nil, show_button: nil, button_text: nil, attachment: nil)
    @id = id
    @title = title || DataGenerator.title
    @ref = ref
    @type = type
    @description = description
    @show_button = show_button
    @button_text = button_text
    @attachment = attachment
  end

  def self.from_response(response)
    properties = response[:properties]
    block_params = response.keep_if { |k, _| k != :properties }
    params = properties.merge(block_params)
    WelcomeScreen.new(params)
  end

  def payload
    payload = {}
    payload[:properties] = {}

    payload[:title] = title
    payload[:ref] = ref unless ref.nil?
    payload[:properties][:description] = description unless description.nil?
    payload[:properties][:show_button] = show_button unless show_button.nil?
    payload[:properties][:button_text] = button_text unless button_text.nil?
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
      (show_button.nil? ? WelcomeScreen.default.show_button == actual.show_button : show_button == actual.show_button) &&
      (button_text.nil? ? WelcomeScreen.default.button_text == actual.button_text : button_text == actual.button_text)
  end

  def self.default
    WelcomeScreen.new(show_button: true, button_text: 'start')
  end

  def self.full_example(id: nil)
    WelcomeScreen.new(
      ref: DataGenerator.field_ref,
      description: DataGenerator.description,
      show_button: false,
      button_text: 'Click me!',
      id: id,
      attachment: Block.attachment
    )
  end
end
