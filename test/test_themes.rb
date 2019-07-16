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
  class ThemesTest < TestBase
    def test_all_requests
      theme = Theme.full_example

      create_theme = CreateThemeRequest.new(theme)
      assert_equal create_theme.success?, true
      assert_equal theme.same?(create_theme.theme), true
      theme = create_theme.theme

      retrieve_theme = RetrieveThemeRequest.new(theme)
      assert_equal retrieve_theme.success?, true
      assert_equal theme.same?(retrieve_theme.theme), true
      theme = retrieve_theme.theme

      retrieve_all_themes = RetrieveAllThemesRequest.new(page: 1, page_size: 2, visibility: 'private')
      assert_equal retrieve_all_themes.success?, true

      update_theme = UpdateThemeRequest.new(theme)
      assert_equal update_theme.success?, true
      assert_equal theme.same?(update_theme.theme), true
      theme = update_theme.theme

      delete_theme = DeleteThemeRequest.new(theme)
      assert_equal delete_theme.success?, true
    end

    def test_same_method
      theme = Theme.full_example
      same_theme = theme.dup

      assert_equal theme.same?(same_theme), true

      not_same_theme = theme.dup
      not_same_theme.name = 'A different title'
      assert_equal theme.same?(not_same_theme), false
    end
  end
end
