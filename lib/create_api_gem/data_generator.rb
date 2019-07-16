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

require 'ffaker'

module Typeform
  module DataGenerator
    def self.title
      FFaker::Movie.title
    end

    def self.description
      FFaker::Lorem.paragraph
    end

    def self.email
      FFaker::Internet.email
    end

    def self.color_code
      '#' + SecureRandom.hex(3)
    end

    def self.field_ref
      SecureRandom.hex(6)
    end

    def self.uuid
      SecureRandom.uuid
    end
  end
end
