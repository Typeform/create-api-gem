require 'minitest/autorun'
require 'create_api_gem'

class ThemesTest < Minitest::Test

    def token
        ENV['TYPEFORM_API_TOKEN']
    end

    def test_crud
        theme = Theme.full_example
        create_theme = CreateThemeRequest.new(token, theme)
        assert_equal create_theme.success?, true
        theme = create_theme.theme

        retrieve_theme = RetrieveThemeRequest.new(token, theme)
        assert_equal retrieve_theme.success?, true
        theme = retrieve_theme.theme

        update_theme = UpdateThemeRequest.new(token, theme)
        assert_equal update_theme.success?, true
        theme = update_theme.theme

        delete_theme = DeleteThemeRequest.new(token, theme)
        assert_equal delete_theme.success?, true
    end

end
