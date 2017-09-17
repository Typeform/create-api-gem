class ThankYouScreen < Block
  attr_accessor :title, :ref, :show_button, :button_text, :button_mode, :redirect_url, :share_icons, :attachment

  def initialize(title: nil, ref: nil, show_button: nil, button_text: nil, button_mode: nil, redirect_url: nil, share_icons: nil, attachment: nil)
    @title = title || DataGenerator.title
    @ref = ref
    @show_button = show_button
    @button_text = button_text
    @button_mode = button_mode
    @redirect_url = redirect_url
    @share_icons = share_icons
    @attachment = attachment
  end

  def self.from_response(response)
    properties = response[:properties]
    block_params = response.keep_if { |k, _| k != :properties }
    params = properties.merge(block_params)
    ThankYouScreen.new(params)
  end

  def payload
    payload = {}

    payload[:title] = title
    payload[:ref] = ref unless ref.nil?
    unless show_button.nil? && button_text.nil? && button_mode.nil? && redirect_url.nil? && share_icons.nil?
      payload[:properties] = {}
      payload[:properties][:show_button] = show_button unless show_button.nil?
      payload[:properties][:button_text] = button_text unless button_text.nil?
      payload[:properties][:button_mode] = button_mode unless button_mode.nil?
      payload[:properties][:redirect_url] = redirect_url unless redirect_url.nil?
      payload[:properties][:share_icons] = share_icons unless share_icons.nil?
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same?(actual)
    title == actual.title &&
      (ref.nil? || ref == actual.ref) &&
      (show_button.nil? ? ThankYouScreen.default.show_button == actual.show_button : show_button == actual.show_button) &&
      (button_text.nil? || button_text == actual.button_text) &&
      (button_mode.nil? ? ThankYouScreen.default.button_mode == actual.button_mode : button_mode == actual.button_mode) &&
      (redirect_url.nil? || redirect_url == actual.redirect_url) &&
      (share_icons.nil? ? ThankYouScreen.default.share_icons == actual.share_icons : share_icons == actual.share_icons)
  end

  def self.default
    ThankYouScreen.new(show_button: true, button_mode: 'reload', share_icons: true)
  end

  def self.full_example
    ThankYouScreen.new(
        title: 'A thank you screen',
        ref: Block.ref,
        show_button: false,
        button_text: 'Click me!',
        button_mode: 'redirect',
        redirect_url: 'http://www.google.com',
        share_icons: false,
        attachment: Block.attachment
        )
  end
end
