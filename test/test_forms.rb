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

  def test_same
    form = Form.full_example
    same_form = form.dup
    assert_equal form.same?(same_form), true

    not_same_form = form.dup
    not_same_form.title = 'A different title'
    assert_equal form.same?(not_same_form), false
  end

end
