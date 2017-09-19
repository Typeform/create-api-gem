class Form
  attr_accessor :id, :title, :blocks, :hidden, :theme_url, :welcome_screens, :thank_you_screens, :logic, :settings, :variables

  def initialize(id: nil, title: nil, blocks: [], hidden: [], theme_url: nil, welcome_screens: [], thank_you_screens: [], logic: [], settings: nil, variables: nil)
    @id = id
    @title = title || DataGenerator.title
    @blocks = blocks
    @hidden = hidden
    @theme_url = theme_url
    @welcome_screens = welcome_screens
    @thank_you_screens = thank_you_screens
    @logic = logic
    @settings = settings
    @variables = variables
  end

  def self.from_response(payload)
    blocks = payload[:fields].nil? ? [] : payload[:fields].map { |field_payload| Block.from_response(field_payload) }
    welcome_screens = payload[:welcome_screens].nil? ? [] : payload[:welcome_screens].map { |welcome_screen_payload| WelcomeScreen.from_response(welcome_screen_payload) }
    thank_you_screens = payload[:thankyou_screens].nil? ? [] : payload[:thankyou_screens].map { |thank_you_screen_payload| ThankYouScreen.from_response(thank_you_screen_payload) }
    hidden_fields = payload[:hidden].nil? ? [] : payload[:hidden]
    logic = payload[:logic].nil? ? [] : payload[:logic].map { |logic_payload| FieldLogic.from_response(logic_payload) }
    settings = Settings.from_response(payload[:settings])
    variables = Variables.from_response(payload[:variables])
    new(
      id: payload[:id],
      title: payload[:title],
      blocks: blocks,
      hidden: hidden_fields,
      theme_url: payload[:theme][:href],
      welcome_screens: welcome_screens,
      thank_you_screens: thank_you_screens,
      logic: logic,
      settings: settings,
      variables: variables
    )
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:id] = id unless id.nil?
    payload[:hidden] = hidden unless hidden.empty?
    payload[:theme] = { href: theme_url } unless theme_url.nil?
    payload[:fields] = blocks.map(&:payload) unless blocks.empty?
    payload[:welcome_screens] = welcome_screens.map(&:payload) unless welcome_screens.empty?
    payload[:thankyou_screens] = thank_you_screens.map(&:payload) unless thank_you_screens.empty?
    payload[:logic] = logic.map(&:payload) unless logic.empty?
    payload[:settings] = settings.payload unless settings.nil?
    payload[:variables] = variables.payload unless variables.nil?
    payload.to_json
  end

  def same?(actual)
    (id.nil? || id == actual.id) &&
      (hidden.nil? || hidden == actual.hidden) &&
      theme_url.nil? || theme_url == actual.theme_url &&
        title == actual.title &&
        same_blocks?(actual.blocks) &&
        same_welcome_screens?(actual.welcome_screens) &&
        same_thank_you_screens?(actual.thank_you_screens) &&
        same_logic?(actual.logic) &&
        (settings.nil? ? Settings.default : settings).same?(actual.settings) &&
      (variables.nil? ? Variables.default : variables).same?(actual.variables)
  end

  def same_blocks?(actual_blocks)
    blocks.zip(actual_blocks).all? do |expected, actual|
      expected.same?(actual)
    end && blocks.length == actual_blocks.length
  end

  def same_welcome_screens?(actual_welcome_screens)
    welcome_screens.zip(actual_welcome_screens).all? do |expected, actual|
      expected.same?(actual)
    end && welcome_screens.length == actual_welcome_screens.length
  end

  def same_thank_you_screens?(actual_thank_you_screens)
    thank_you_screens.zip(actual_thank_you_screens).all? do |expected, actual|
      expected.same?(actual)
    end && thank_you_screens.length == actual_thank_you_screens.length
  end

  def same_logic?(actual_logic)
    logic.all? do |field_logic|
      actual_field_logic = actual_logic.find { |fl| fl.field_ref == field_logic.field_ref }
      field_logic.same?(actual_field_logic)
    end  && logic.length == actual_logic.length
  end

  def theme_id
    theme_url.split('/themes/')[1]
  end

  def add_logic_action(field_ref, logic_action)
    field_logic = logic.find { |current_field_logic| current_field_logic.field_ref == field_ref }
    field_logic.nil? ? logic << FieldLogic.new(type: 'field', field_ref: field_ref, actions: [logic_action]) : field_logic.actions << logic_action
  end

  def self.with_all_blocks
    blocks = Block.all_types.values.map do |block|
      if block == GroupBlock
        fields = Block.all_types.values.map do |block|
          block.new unless block == GroupBlock || block == PaymentBlock
        end
        block.new(fields: fields)
      else
        block.new
      end
    end

    Form.new(
      blocks: blocks
    )
  end

  def self.full_example(id: nil)
    blocks = Block.all_types.values.map(&:full_example)
    email_block = blocks.find { |current_block| current_block.type == :email }
    form = Form.new(
      id: id,
      hidden: %w[hiddenfield1 hiddenfield2],
      theme_url: "#{APIConfig.api_request_url}/themes/default",
      blocks: blocks,
      welcome_screens: [WelcomeScreen.full_example],
      thank_you_screens: [ThankYouScreen.full_example],
      settings: Settings.full_example(email_block.ref),
      variables: Variables.full_example
    )
    form.logic = blocks.map { |block| FieldLogic.full_example(block, form)}
    form
  end
end
