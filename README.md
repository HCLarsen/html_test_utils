# HTML Test Utils

**NOTE:** This is a Github placeholder repo for the project's true repo on Gitlab. You can raise issues using this repo, but all code will be found [here](https://gitlab.com/HCLarsen/html_test_utils)

HTML Test Utils is a library that makes it easier to test generated HTML in your Crystal projects. Largely inspired by [Vue Test Utils](https://test-utils.vuejs.org/), and powered by [Lexbor](https://github.com/kostya/lexbor).

### Why HTML Test Utils?

Testing HTML strings in Crystal isn't easy. It's possible to use `Regex` or `Lexbor` to test the structure and content of HTML, but neither one is very convenient. `HTML Test Utils` provides just this convenience, making it easy to traverse the structure of an HTML document, and query the elements in the ways that would be used during testing.
