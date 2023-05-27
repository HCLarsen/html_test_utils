require "./wrapper"

# TODO: Write documentation for `HtmlTestUtils`
module HTMLTestUtils
  VERSION = "0.1.0"

  def self.parse(html : String) : Wrapper
    lexbor = Lexbor::Parser.new(html)

    Wrapper.new(lexbor.root!)
  end
end
