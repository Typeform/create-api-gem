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

module Typeform
  class Workspace
    attr_accessor :name, :id, :default, :shared, :members

    def initialize(name: nil, id: nil, default: nil, shared: nil, members: nil)
      @name = name || DataGenerator.title
      @id = id
      @default = default
      @shared = shared
      @members = members
    end

    def payload
      {
        name: name
      }.to_json
    end

    def same?(actual)
      name == actual.name &&
        id.nil? || id == actual.id &&
          (default.nil? ? Workspace.default.default : default) == actual.default &&
          (shared.nil? ? Workspace.default.shared : shared) == actual.shared
    end

    def self.default
      Workspace.new(default: false, shared: false)
    end

    def self.from_response(payload)
      new(
        name: payload[:name],
        id: payload[:id],
        default: payload[:default],
        shared: payload[:shared],
        members: payload[:members]
      )
    end
  end
end
