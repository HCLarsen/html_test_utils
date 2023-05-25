require "minitest/autorun"

require "/../src/wrapper"

class WrapperTest < Minitest::Test
  @node : Lexbor::Node?

  def node
    return @node if @node

    weather = File.open("#{__DIR__}/files/weekly_weather.html")
    lexbor = Lexbor::Parser.new(weather)
    @node = lexbor.document
  end

  def test_initializes_wrapper
    wrapper = HTMLTestUtils::Wrapper.new(node)

    assert wrapper.exists?
  end

  def test_initializes_empty_wrapper
    wrapper = HTMLTestUtils::Wrapper.new(nil)

    refute wrapper.exists?
  end

  def test_finds_single_nested_element
    wrapper = HTMLTestUtils::Wrapper.new(node)

    days = wrapper.find("#days")

    assert days.exists?
  end

  def test_doesnt_find_nonexistent_element
    wrapper = HTMLTestUtils::Wrapper.new(node)

    emptywrapper = wrapper.find(".noclass")

    refute emptywrapper.exists?
  end

  def test_raises_on_find_for_empty_wrapper
    wrapper = HTMLTestUtils::Wrapper.new(nil)

    error = assert_raises do
      wrapper.find(".noclass")
    end

    assert_equal "Error: cannot call find on empty wrapper", error.message
  end

  def test_finds_multiple_elements
    wrapper = HTMLTestUtils::Wrapper.new(node)

    days = wrapper.find_all(".day .conditions")

    assert_equal 5, days.size
  end

  def test_returns_empty_array_for_no_elements
    wrapper = HTMLTestUtils::Wrapper.new(node)

    emptywrappers = wrapper.find_all(".noclass")

    assert_equal 0, emptywrappers.size
  end

  def test_returns_text_of_elements
    wrapper = HTMLTestUtils::Wrapper.new(node)

    monday_conditions = wrapper.find(".day:first-of-type .conditions")
    assert_equal "Clear sky", monday_conditions.text

    monday_temp = wrapper.find(".day:first-of-type h1")
    assert_equal "10oC", monday_temp.text
  end

  def test_returns_classes
    lexbor = Lexbor::Parser.new(%(<html><body><p class="text paragraph random">Just a random paragraph</p></body></html>))
    node = lexbor.css("p").first
    wrapper = HTMLTestUtils::Wrapper.new(node)

    assert_equal ["text", "paragraph", "random"], wrapper.classes
  end

  def test_returns_id
    wrapper = HTMLTestUtils::Wrapper.new(node)
    days = wrapper.find("section")

    assert_equal "days", days.id

    day = wrapper.find(".day")

    refute day.id
  end

  def test_returns_tag
    wrapper = HTMLTestUtils::Wrapper.new(node)
    days = wrapper.find("#days")

    assert_equal "section", days.tag
  end

  def test_returns_attributes
    wrapper = HTMLTestUtils::Wrapper.new(node)
    days = wrapper.find("#days")

    attributes = days.attributes

    assert_equal "main", attributes["role"]
    assert_equal "color:red", attributes["style"]
  end

  def test_returns_single_attribute
    wrapper = HTMLTestUtils::Wrapper.new(node)
    days = wrapper.find("#days")

    assert_equal "main", days.attribute_by("role")
    assert_equal "color:red", days.attribute_by("style")
  end
end
