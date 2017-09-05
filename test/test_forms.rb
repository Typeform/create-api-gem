require 'minitest/autorun'
require 'create_api_gem'

class FormsTest < Minitest::Test

    def test_crud
        form = Form.full_example
        create_form = CreateFormRequest.new('DHDPHdKJjJxSjv6ORG98upmUb_Ayupq5kjgNXbGAlF4=', form)
        assert_equal create_form.success?, true
        form = create_form.form

        retrieve_form = RetrieveFormRequest.new('DHDPHdKJjJxSjv6ORG98upmUb_Ayupq5kjgNXbGAlF4=', form)
        assert_equal retrieve_form.success?, true
        form = retrieve_form.form

        update_form = UpdateFormRequest.new('DHDPHdKJjJxSjv6ORG98upmUb_Ayupq5kjgNXbGAlF4=', form)
        assert_equal update_form.success?, true
        form = update_form.form

        delete_form = DeleteFormRequest.new('DHDPHdKJjJxSjv6ORG98upmUb_Ayupq5kjgNXbGAlF4=', form)
        assert_equal delete_form.success?, true
    end

end
