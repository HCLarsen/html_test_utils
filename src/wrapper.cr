require "lexbor"

class HTMLTestUtils::Wrapper
  def initialize(@node : Lexbor::Node?)
  end

  # Returns a `String` of the attribute specified by *attr_name*, or `nil` if the
  # element doesn't have the specified attribute.
  #
  # The element's classes can be determined this way, but they will be returned as a
  # single string, as opposed to `#classes`, which returns them as an array.
  def attribute_by(attr_name : String) : String?
    raise_if_empty("attribute_by")

    @node.not_nil!.attribute_by(attr_name)
  end

  # Returns a `Hash` containing all the element's attributes.
  #
  # Classes are include in this `Hash`, but they're returned as a single `String`, not an
  # `Array`, as `#classes` does.
  def attributes : Hash(String, String)
    raise_if_empty("attributes")

    @node.not_nil!.attributes
  end

  # Returns an `Array` of classes for the element, or an empty `Array` if the element has
  # no classes.
  def classes : Array(String)
    raise_if_empty("classes")

    classes = @node.not_nil!.attribute_by("class")

    if classes
      return classes.split
    else
      return [] of String
    end
  end

  # Returns a `Bool` that indicates if the specified HTML exists within the parsed HTML
  # tree.
  def exists? : Bool
    !@node.nil?
  end

  # Returns a `Wrapper` for the HTML element that matches *selector*. If more than one
  # element matches *selector*, then it will return the first one it finds.
  #
  # If no matching element is found, the returned `Wrapper` will be empty, thus it will
  # return `false` for `#exists?`, and raise an error on any other queries.
  #
  # The syntax for *selector* is the same that is used by standard CSS rules.
  def find(selector : String) : Wrapper
    raise_if_empty("find")

    Wrapper.new(@node.not_nil!.css(selector).first?)
  end

  # Returns an `Array` of `Wrapper` objects that match *selector*. If no matching elements
  # are found, an empty `Wrapper` is returned.
  #
  # The syntax for *selector* is the same that is used by standard CSS rules.
  def find_all(selector : String) : Array(Wrapper)
    raise_if_empty("find_all")

    @node.not_nil!.css(selector).map do |result|
      Wrapper.new(result)
    end
  end

  # Returns the id property of the element if it has one, or `nil` if there is no id.
  def id : String?
    raise_if_empty("id")

    @node.not_nil!["id"]?
  end

  # Return the HMTL tag of the element.
  def tag : String
    raise_if_empty("tag")

    @node.not_nil!.tag_name
  end

  # Returns all of the text within the element, including that of child elements.
  def text : String
    raise_if_empty("text")

    @node.not_nil!.inner_text
  end

  private def raise_if_empty(method_name : String)
    if @node.nil?
      raise "Error: cannot call #{method_name} on empty wrapper"
    end
  end
end
