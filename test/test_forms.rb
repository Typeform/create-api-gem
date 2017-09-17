require 'minitest/autorun'
require 'create_api_gem'

class FormsTest < Minitest::Test
  def token
    ENV['TYPEFORM_API_TOKEN']
  end

  def test_crud
    form = Form.full_example
    
    create_form = CreateFormRequest.new(token, form)
    assert_equal create_form.success?, true
    form = create_form.form

    retrieve_form = RetrieveFormRequest.new(token, form)
    assert_equal retrieve_form.success?, true
    form = retrieve_form.form

    update_form = UpdateFormRequest.new(token, form)
    assert_equal update_form.success?, true
    form = update_form.form

    delete_form = DeleteFormRequest.new(token, form)
    assert_equal delete_form.success?, true
  end
end
