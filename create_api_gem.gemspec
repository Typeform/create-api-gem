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

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'create_api_gem/version'

Gem::Specification.new do |spec|
  spec.name          = 'create_api_gem'
  spec.version       = CreateApiGem::VERSION
  spec.authors       = ['Typeform']
  spec.email         = ['opensource@typeform.com']

  spec.summary       = 'Typeform Create API Gem'
  spec.description   = 'Ruby gem for using the Typeform Create API'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0.1'
  spec.add_development_dependency 'rake', '~> 12.3.2'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'rest-client', '>=2'
  spec.add_dependency 'ffaker'
  spec.add_dependency 'json'
  spec.add_dependency 'rack'
end
