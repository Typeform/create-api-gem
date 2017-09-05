class Background
  attr_accessor :href, :brightness, :layout

  def initialize(href: nil, brightness: nil, layout: nil)
    raise ArgumentError.new('href must be a link to an image') unless href.start_with?("#{APIConfig.clafoutis_address}/images/")
    raise ArgumentError.new('brightness must be between 0 and 1') unless brightness.between?(0, 1)
    raise ArgumentError.new('layout must be one of the allowed values') unless ['repeat', 'no-repeat'].include?(layout)
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
