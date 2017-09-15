class Background
  attr_accessor :href, :brightness, :layout

  def initialize(href: nil, brightness: nil, layout: nil)
    @href = href
    @brightness = brightness
    @layout = layout
  end

  def payload
    payload = {
      href: href
    }
    payload[:brightness] = brightness unless brightness.nil?
    payload[:layout] = layout unless layout.nil?
    payload
  end

  def self.from_response(payload)
    new(
      href: payload[:href],
      layout: payload[:layout],
      brightness: payload[:brightness]
    )
  end

  def self.default
    Background.new(
      brightness: 0,
      layout: 'repeat'
    )
  end

  def self.full_example
    Background.new(
      href: "#{APIConfig.clafoutis_address}/images/default",
      brightness: 0.5,
      layout: 'no-repeat'
    )
  end

  def same?(actual)
    (layout.nil? ? Background.default.layout : layout) == actual.layout &&
      (brightness.nil? ? Background.default.brightness : brightness) == actual.brightness
  end
end
