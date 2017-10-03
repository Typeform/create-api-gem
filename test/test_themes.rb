require 'minitest/autorun'
require 'create_api_gem'

class ThemesTest < TestBase
  def test_all_requests
    theme = Theme.full_example

    create_theme = CreateThemeRequest.new(token, theme)
    assert_equal create_theme.success?, true
    assert_equal theme.same?(create_theme.theme), true
    theme = create_theme.theme

    retrieve_theme = RetrieveThemeRequest.new(token, theme)
    assert_equal retrieve_theme.success?, true
    assert_equal theme.same?(retrieve_theme.theme), true
    theme = retrieve_theme.theme

    retrieve_all_themes = RetrieveAllThemesRequest.new(token, page: 1, page_size: 2, visibility: 'private')
    assert_equal retrieve_all_themes.success?, true

    update_theme = UpdateThemeRequest.new(token, theme)
    assert_equal update_theme.success?, true
    assert_equal theme.same?(update_theme.theme), true
    theme = update_theme.theme

    delete_theme = DeleteThemeRequest.new(token, theme)
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
