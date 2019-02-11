# Create API Gem

Welcome to the Create API Gem! This gem provides a way of interacting with [Typeforms Create API](https://developer.typeform.com/create/) if you are programming in Ruby. We have created object representations of forms, themes, images, workspaces and teams so you can programmatically create all of the afore mentioned using Ruby nice and easily. Also you'll find all the requests needed to perform CRUD operations on each of these entities.

## Getting Started

So before using the gem we recommend familiarizing yourself a little bit with our API. You can check out our [Get-Started](https://developer.typeform.com/get-started/) documentation.

You will also need a [Personal Access Token](https://developer.typeform.com/get-started/personal-access-token/) if you want to see anything you make with this gem appear in your Typeform account.

Once you have this token, we recommend for security reasons saving it as an `TYPEFORM_API_TOKEN` environment variable. Also it will save you writing some code later on, if you don't want to do this just yet it is still possible to use the gem, but as we say - it is recommended.

### Installation

Add this line to your application's Gemfile:

`gem 'create_api_gem', git: 'https://github.com/Typeform/create-api-gem.git'`

And then execute:

`bundle install`

Wherever you use the gem, it is easiest to require it like so:

```
require 'bundler'
Bundler.require
```

This should require all the gems in your Gemfile for you.

### Usage

Now we're ready to develop. Let's say you want to create a form, you will just need to create a `Form` object and send it to our API's using a `CreateFormRequest`.

`CreateFormRequest.execute(Form.new)` - voila!

(We use `.execute` instead of `.new` on the `CreateFormRequest` to check that we get back the correct status code)

Note: This will only work if you have set the environment variable as mentioned before. You can explicitly pass a token like this

`CreateFormRequest.execute(Form.new, token: 'your-token-goes-here')`

If you check in your Typeform account you should have a form in there with a funny name. That's the one you just created! The funny name comes from [this](https://github.com/ffaker/ffaker) gem, as you can't create a form without a title. You'll probably want to decide your own title, you can do this like so

`CreateFormRequest.execute(Form.new(title: 'My new form'), token: 'your-token-goes-here')`

So we have create a form! Let's add some things to it. By assigning the result of the requests `.form` method we can receive a `Form` object to interact with

`form = CreateFormRequest.execute(Form.new).form`

Now we can add some blocks. Likewise with the form, if you simply call `.new` on a block, the gem will generate the bare minimum data required for that block. For example

`form.blocks << ShortTextBlock.new`

Now you're form has a block, but Typeform doesn't know that yet, so we need to send a request back to Typeform to update the form, again we can assign the result back to our original variable.

`form = UpdateFormRequest.execute(form).form`

If you want to use an existing form of yours, you can do so like this

`form = RetrieveFormRequest.execute(Form.new(id: 'your-form-id-goes-here')).form`

You can find your form's ID on the end of the URL for the typeform.

## Development

After checking out the repo, you can run `rake console` to load the gem using the interactive ruby console.

## Appendix

Here are the links to the classes that you can use.

### Forms

#### Requests
[CreateFormRequest](lib/create_api_gem/forms/requests/create_form_request.rb)  
[RetrieveFormRequest](lib/create_api_gem/forms/requests/retrieve_form_request.rb)  
[RetrieveAllFormsRequest](lib/create_api_gem/forms/requests/retrieve_all_forms_request.rb)  
[UpdateFormRequest](lib/create_api_gem/forms/requests/update_form_request.rb)  
[UpdateFormPatchRequest](lib/create_api_gem/forms/requests/update_form_patch_request.rb)  
[HeadFormRequest](lib/create_api_gem/forms/requests/head_form_request.rb)  
[DeleteFormRequest](lib/create_api_gem/forms/requests/delete_form_request.rb)

#### Elements

[Form](lib/create_api_gem/forms/form.rb)  

[DateBlock](lib/create_api_gem/forms/blocks/date_block.rb)  
[DropdownBlock](lib/create_api_gem/forms/blocks/dropdown_block.rb)  
[EmailBlock](lib/create_api_gem/forms/blocks/email_block.rb)  
[FileUploadBlock](lib/create_api_gem/forms/blocks/file_upload_block.rb)  
[GroupBlock](lib/create_api_gem/forms/blocks/group_block.rb)  
[LegalBlock](lib/create_api_gem/forms/blocks/legal_block.rb)  
[LongTextBlock](lib/create_api_gem/forms/blocks/long_text_block.rb)  
[MultipleChoiceBlock](lib/create_api_gem/forms/blocks/multiple_choice_block.rb)  
[NumberBlock](lib/create_api_gem/forms/blocks/number_block.rb)  
[OpinionScaleBlock](lib/create_api_gem/forms/blocks/opinion_scale_block.rb)  
[PaymentBlock](lib/create_api_gem/forms/blocks/payment_block.rb)  
[PictureChoiceBlock](lib/create_api_gem/forms/blocks/picture_choice_block.rb)  
[PhoneNumberBlock](lib/create_api_gem/forms/blocks/phone_number_block.rb)
[RatingBlock](lib/create_api_gem/forms/blocks/rating_block.rb)  
[ShortTextBlock](lib/create_api_gem/forms/blocks/short_text_block.rb)  
[StatementBlock](lib/create_api_gem/forms/blocks/statement_block.rb)  
[WebsiteBlock](lib/create_api_gem/forms/blocks/website_block.rb)  
[YesNoBlock](lib/create_api_gem/forms/blocks/yes_no_block.rb)   

[ThankYouScreen](lib/create_api_gem/forms/blocks/thank_you_screen.rb)  
[WelcomeScreen](lib/create_api_gem/forms/blocks/welcome_screen.rb)

[LogicJump](lib/create_api_gem/forms/logic/actions/logic_jump.rb)  
[Calculation](lib/create_api_gem/forms/logic/actions/calculation.rb)

[Settings](lib/create_api_gem/forms/settings/settings.rb)  
[Notifications](lib/create_api_gem/forms/settings/notifications.rb)  
[Variables](lib/create_api_gem/forms/variables.rb)  
[Messages](lib/create_api_gem/forms/messages.rb) 

### Images

#### Requests

[CreateImageRequest](lib/create_api_gem/images/requests/create_image_request.rb)  
[CreateImageFromUrlRequest](lib/create_api_gem/images/requests/create_image_from_url_request.rb)  
[RetrieveImageRequest](lib/create_api_gem/images/requests/retrieve_image_request.rb)  
[RetrieveAllImagesRequest](lib/create_api_gem/images/requests/retrieve_all_images_request.rb)  
[DeleteImageRequest](lib/create_api_gem/images/requests/retrieve_image_request.rb)  

#### Elements

[Image](lib/create_api_gem/images/image.rb)

### Teams

#### Requests

[RetrieveTeamRequest](lib/create_api_gem/teams/requests/retrieve_team_request.rb)  
[UpdateTeamRequest](lib/create_api_gem/teams/requests/update_team_request.rb)  

### Themes

#### Requests

[CreateThemeRequest](lib/create_api_gem/themes/requests/create_theme_request.rb)  
[RetrieveThemeRequest](lib/create_api_gem/themes/requests/retrieve_theme_request.rb)  
[RetrieveAllThemesRequest](lib/create_api_gem/themes/requests/retrieve_all_themes_request.rb)  
[UpdateThemeRequest](lib/create_api_gem/themes/requests/update_theme_request.rb)  
[DeleteThemeRequest](lib/create_api_gem/themes/requests/delete_theme_request.rb)  

#### Elements

[Theme](lib/create_api_gem/themes/theme.rb)
[Background](lib/create_api_gem/themes/background.rb)

### Workspaces

[CreateWorkspaceRequest](lib/create_api_gem/workspaces/requests/create_workspace_request.rb)  
[RetrieveWorkspaceRequest](lib/create_api_gem/workspaces/requests/retrieve_workspace_request.rb)  
[RetrieveAllWorkspacesRequest](lib/create_api_gem/workspaces/requests/retrieve_all_workspaces_request.rb)  
[RetrieveDefaultWorkspaceRequest](lib/create_api_gem/workspaces/requests/retrieve_default_workspace_request.rb)  
[UpdateWorkspaceRequest](lib/create_api_gem/workspaces/requests/update_workspace_request.rb)  
[DeleteWorkspaceRequest](lib/create_api_gem/workspaces/requests/delete_workspace_request.rb)  

#### Elements

[Workspace](lib/create_api_gem/workspaces/workspace.rb)

## Code of Conduct

[See our code of conduct here](CODE_OF_CONDUCT.md)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Typeform/create-api-gem.

When writing Ruby code we use *Rubocop* as a static code analyzer. You can run `rubocop` from the route folder to make sure that your code fits the conventions we have set inside the '.rubocop.yml' file.

### Versioning

We follow the semantic versioning as defined by rubygems.org

## Alternatives

This is just a Ruby wrapper for our API's, they use the JSON format so they are extremely flexible. There are many alternatives!

Check out our developers documentation at developers.typeform.com

## Legal

Copyright 2017 Typeform SL. under the Apache 2 License; see the LICENSE file for more information.

This is not an official Typeform product.
