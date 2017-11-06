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

If you want to use an existing form of yours, you can do so like so

`form = RetrieveFormRequest.execute(Form.new(id: 'your-form-id-goes-here')).form`

You can find your form's ID on the end of the URL for the typeform.

## Development

After checking out the repo, you can run `rake console` to load the gem using the interactive ruby console.

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
