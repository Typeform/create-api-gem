# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require_relative 'block'

module Typeform
  class FileUploadBlock < Block
    attr_accessor :id, :title, :type, :ref, :description, :required

    def initialize(id: nil, title: nil, type: :file_upload, ref: nil, description: nil, required: nil)
      @id = id
      @title = title || DataGenerator.title
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
        required: false
      )
    end

    def self.full_example(id: nil)
      FileUploadBlock.new(
        ref: DataGenerator.field_ref,
        description: DataGenerator.description,
        required: true,
        id: id
      )
    end
  end
end