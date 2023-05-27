require "minitest/autorun"

require "../src/html_test_utils"

class HTMLTestUtilsTest < Minitest::Test
  def test_parses_html_string
    weather = File.read("#{__DIR__}/files/weekly_weather.html")

    wrapper = HTMLTestUtils.parse(weather)
    assert_equal "html", wrapper.tag

    section = wrapper.find("#days")
    assert_equal "section", section.tag

    days = section.find_all(".day")
    assert_equal 5, days.size

    monday_date = days[0].find("h2")
    assert_equal "Mar 22", monday_date.text
  end
end
