require 'minitest/autorun'
require 'kramdown-prismic'

class KramdownPrismicParserTest < Minitest::Test
  def test_convert_empty
    expected = ""
    assert_equal expected, Kramdown::Document.new([], input: :prismic).to_kramdown
  end

  def test_convert_heading
    prismic = [
      {
        type: "heading1",
        content: {
          text: "This is the document title",
          spans: []
        }
      }
    ]
    expected = "# This is the document title\n\n"
    assert_equal expected, Kramdown::Document.new(prismic, input: :prismic).to_kramdown
  end

  def test_convert_heading2
    prismic = [
      {
        type: "heading2",
        content: {
          text: "This is the document title 2",
          spans: []
        }
      }
    ]
    expected = "## This is the document title 2\n\n"
    assert_equal expected, Kramdown::Document.new(prismic, input: :prismic).to_kramdown
  end

  def test_convert_italic
    prismic = [
      {
        type: "heading2",
        content: {
          text: "This is the document title 2",
          spans: [
            {
              type: 'em',
              start: 0,
              end: 4
            },
            {
              type: 'em',
              start: 21,
              end: 26
            }
          ]
        }
      }
    ]
    expected = "## *This* is the document *title* 2\n\n"
    assert_equal expected, Kramdown::Document.new(prismic, input: :prismic).to_kramdown
  end
end
