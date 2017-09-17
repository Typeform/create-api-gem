require_relative 'block'

class PaymentBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required, :currency, :price, :show_button, :button_text, :attachment

  def initialize(id: nil, title: nil, type: :payment, ref: nil, description: nil, required: nil, currency: nil, price: nil,
                 show_button: nil, button_text: nil, attachment: nil)
    @id = id
    @title = title || DataGenerator.title
    @type = type
    @ref = ref
    @description = description
    @required = required
    @currency = currency
    @price = price
    @show_button = show_button
    @button_text = button_text
    @attachment = attachment
  end

  def payload
    payload = {}
    payload[:title] = title
    payload[:type] = type.to_s
    payload[:id] = id unless id.nil?
    payload[:ref] = ref unless ref.nil?
    unless description.nil? && currency.nil? && price.nil? && show_button.nil? && button_text.nil?
      payload[:properties] = {}
      payload[:properties][:description] = description
      payload[:properties][:currency] = currency
      payload[:properties][:price] = price
      payload[:properties][:show_button] = show_button
      payload[:properties][:button_text] = button_text
    end
    unless required.nil?
      payload[:validations] = {}
      payload[:validations][:required] = required
    end
    payload[:attachment] = attachment unless attachment.nil?
    payload
  end

  def same_extra_attributes?(actual)
    (required.nil? ? PaymentBlock.default.required : required) == actual.required &&
      (price.nil? ? PaymentBlock.default.price : price) == actual.price &&
      (currency.nil? ? PaymentBlock.default.currency : currency) == actual.currency &&
      (show_button.nil? || show_button == actual.show_button) &&
      (button_text.nil? || button_text == actual.button_text) &&
      (attachment.nil? || attachment == actual.attachment)
  end

  def self.default
    PaymentBlock.new(
      required: false,
      price: { type: 'variable', value: 'price' },
      currency: 'EUR'
    )
  end

  def self.full_example(id: nil)
    PaymentBlock.new(
      ref: Block.ref,
      description: DataGenerator.description,
      id: id,
      required: true,
      currency: 'USD',
      price: { type: 'variable', value: 'price' },
      show_button: true, button_text: 'Click me!',
      attachment: Block.attachment
    )
  end
end
