require_relative 'block'

class FileUploadBlock < Block
  attr_accessor :id, :title, :type, :ref, :description, :required

  def initialize(id: nil, title:, type: :file_upload, ref: nil, description: nil, required: nil)
    @id = id
    @title = title || Fake.title
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
    (required.nil? ? FileUploadBlock.default.required : required) == actual.required
  end

  def self.default
    FileUploadBlock.new(
        title: 'A file upload block',
        required: false
    )
  end

  def self.full_example(id: nil)
    FileUploadBlock.new(
        title: 'A file upload block',
        ref: Block.ref,
        description: 'a description of the file upload block',
        required: true,
        id: id
    )
  end
end
