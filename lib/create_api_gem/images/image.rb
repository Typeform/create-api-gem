class Image
  attr_accessor :id, :image, :media_type, :file_name, :width, :height, :has_alpha, :avg_color

  def initialize(id: nil, image: nil, media_type: nil, file_name: nil, width: nil, height: nil, has_alpha: nil, avg_color: nil)
    @id = id
    @image = image || generate_image
    @media_type = media_type || generate_media_type
    @file_name = file_name || generate_file_name
    @width = width
    @height = height
    @has_alpha = has_alpha
    @avg_color = avg_color
  end

  def self.from_response(payload)
    Image.new(
      id: payload[:id],
      image: payload[:image],
      media_type: payload[:media_type],
      file_name: payload[:file_name],
      width: payload[:width],
      height: payload[:height],
      has_alpha: payload[:has_alpha],
      avg_color: payload[:avg_color]
    )
  end

  def payload
    {
      image: image,
      media_type: media_type,
      file_name: file_name
    }.to_json
  end

  def same?(actual)
    image == actual.image &&
      media_type == actual.media_type &&
      file_name == actual.file_name
  end

  private

  def generate_image
    File.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', 'data', 'dat_swarm_coat_of_arms.txt')))
  end

  def generate_media_type
    'image/png'
  end

  def generate_file_name
    'dat_swarm_coat_of_arms'
  end
end