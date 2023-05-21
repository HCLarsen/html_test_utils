# HTML Test Utils

HTML Test Utils is a library that makes it easier to test generated HTML in your Crystal projects. Largely inspired by [Vue Test Utils](https://test-utils.vuejs.org/), and powered by [Lexbor](https://github.com/kostya/lexbor).

### Why HTML Test Utils?

Testing HTML strings in Crystal isn't easy. It's possible to use `Regex` or `Lexbor` to test the structure and content of HTML, but neither one is very convenient. `HTML Test Utils` provides just this convenience, making it easy to traverse the structure of an HTML document, and query the elements in the ways that would be used during testing.

### What HTML Test Utils isn't

HTML Test Utils is not a testing framework. It still needs to be used with an existing framework, like [Minitest.cr](https://github.com/ysbaddaden/minitest.cr) or Crystal's buit-in [spec](https://crystal-lang.org/reference/1.8/guides/testing.html) library. What it is, is objects and methods that make it easy to test your HTML string.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     html_test_utils:
       github: HCLarsen/html_test_utils
   ```

2. Run `shards install`

## Usage

Using HTML Test Utils starts with passing an HTML format string to `HTMLTestUtils.parse`. This returns a `HTMLTestUtils::Wrapper` object.

```crystal
require "html_test_utils"

html = "<!DOCTYPE html><html><body><h1>Lorem Ipsum</h1><ul><li>Lorem ipsum dolor sit amet,</li><li>consectetur adipiscing elit,</li><li>sed do eiusmod tempor incididunt.</li></ul></body></html>"

wrapper = HTMLTestUtils.parse(html)
```

Once parsed, it's easy to find any HTML element within the document using the `#find` method with CSS selectors, which also returns a `Wrapper` object. Once obtained, a series of query methods can be used to determine the properties of the element, including the text content.

```crystal
title = wrapper.find("#title")
title.exists?       #=> true
title.text          #=> "Lorum Ipsum"
```

When multiple elements are needed, a convenient `#findAll` method can be used to return an `Array` of `Wrapper` objects.

```crystal
list_items = wrapper.findAll("li")
list_items.size     #=> 3
list_items[0].text  #=> "Lorem ipsum dolor sit amet,"

```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/HCLarsen/html_test_utils/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Chris Larsen](https://github.com/HCLarsen) - creator and maintainer
