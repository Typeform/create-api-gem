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

      retrieve_all_forms = RetrieveAllFormsRequest.new
      assert_equal retrieve_all_forms.success?, true

      update_form = UpdateFormRequest.new(form)
      assert_equal update_form.success?, true
      assert_equal form.same?(update_form.form), true
      form = update_form.form

      patch_operations = [PatchOperation.new(op: 'replace', path: '/title', value: 'new title')]
      update_patch_form = UpdateFormPatchRequest.new(form, patch_operations)
      assert_equal update_patch_form.success?, true

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

    def test_messages
      form = CreateFormRequest.execute(Form.new).form

      retrieve_messages = RetrieveMessagesRequest.new(form)
      assert_equal retrieve_messages.success?, true

      messages = Messages.new('label.button.ok' => 'New Ok')
      update_messages = UpdateMessagesRequest.new(form, messages)
      assert_equal update_messages.success?, true
      assert_equal messages.same?(RetrieveMessagesRequest.execute(form).messages), true

      DeleteFormRequest.execute(form)
    end
  end
end
