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
  class Variables
    attr_accessor :price, :score

    def initialize(price: nil, score: nil)
      @price = price
      @score = score
    end

    def self.from_response(payload)
      new(
        price: payload[:price],
        score: payload[:score]
      )
    end

    def self.default
      Variables.new
    end

    def self.full_example
      Variables.new(price: 10, score: 0)
    end

    def payload
      payload = {}
      payload[:score] = score unless score.nil?
      payload[:price] = price unless price.nil?
      payload
    end

    def same?(actual)
      (score.nil? || score == actual.score) &&
        (price.nil? || price == actual.price)
    end
  end
end
