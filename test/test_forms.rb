require 'minitest/autorun'
require 'create_api_gem'

class FormsTest < TestBase
  def test_all_requests
    form = Form.full_example

    create_form = CreateFormRequest.new(form)
    assert_equal create_form.success?, true
    assert_equal form.same?(create_form.form), true
    form = create_form.form

    retrieve_form = RetrieveFormRequest.new(form)
    assert_equal retrieve_form.success?, true
    assert_equal form.same?(retrieve_form.form), true
    form = retrieve_form.form

    head_form = HeadFormRequest.new(form)
    assert_equal head_form.success?, true

    retrieve_all_forms = RetrieveAllFormsRequest.new(token)
    assert_equal retrieve_all_forms.success?, true

    update_form = UpdateFormRequest.new(form)
    assert_equal update_form.success?, true
    assert_equal form.same?(update_form.form), true
    form = update_form.form

    delete_form = DeleteFormRequest.new(form)
    assert_equal delete_form.success?, true
  end

  def test_form_same_method
    form = Form.full_example
    same_form = form.dup
    assert_equal form.same?(same_form), true

    different_form = form.dup
    different_form.title = DataGenerator.title
    assert_equal form.same?(different_form), false
  end

  def test_block_same_method
    block = ShortTextBlock.full_example
    same_block = block.dup
    assert_equal block.same?(same_block), true

    different_block = block.dup
    different_block.ref = DataGenerator.field_ref
    assert_equal block.same?(different_block), false
  end

  def test_logic_same_method
    logic_jump = LogicJump.create_always_jump(Form.full_example)
    same_logic_jump = logic_jump.dup
    assert_equal logic_jump.same?(same_logic_jump), true

    different_logic_jump = logic_jump.dup
    different_logic_jump.to_ref = DataGenerator.field_ref
    assert_equal logic_jump.same?(different_logic_jump), false
  end

  def test_settings_same_method
    settings = Settings.full_example(DataGenerator.field_ref)
    same_settings = settings.dup
    assert_equal settings.same?(same_settings), true

    different_settings = settings.dup
    different_settings.is_public = false
    assert_equal settings.same?(different_settings), false
  end
end
