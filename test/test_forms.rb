require 'minitest/autorun'
require 'create_api_gem'

class FormsTest < Minitest::Test
  def token
    ENV['TYPEFORM_API_TOKEN']
  end

  def test_crud_operations
    form = Form.full_example

    create_form = CreateFormRequest.new(token, form)
    assert_equal create_form.success?, true
    assert_equal form.same?(create_form.form), true
    form = create_form.form

    retrieve_form = RetrieveFormRequest.new(token, form)
    assert_equal retrieve_form.success?, true
    assert_equal form.same?(retrieve_form.form), true
    form = retrieve_form.form

    update_form = UpdateFormRequest.new(token, form)
    assert_equal update_form.success?, true
    assert_equal form.same?(update_form.form), true
    form = update_form.form

    delete_form = DeleteFormRequest.new(token, form)
    assert_equal delete_form.success?, true
  end

  def test_same_method
    form = Form.full_example
    same_form = form.dup
    assert_equal form.same?(same_form), true

    not_same_form = form.dup
    not_same_form.title = DataGenerator.title
    assert_equal form.same?(not_same_form), false
  end
end
