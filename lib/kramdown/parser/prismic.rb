module Kramdown
  module Parser
    class Prismic < Base
      def parse
        @root.options[:encoding] = 'utf-8'
        return if source.empty?
        text = source.first[:content][:text]
        spans = source.first[:content][:spans]
        case source.first[:type]
        when /heading([1-6])/
          add_header_child($1.to_i, text, spans)
        end
      end

      def add_header_child(level, text, spans)
        header = Kramdown::Element.new(:header, nil, nil, {level: level, raw_text: text})
        children = children_to_add(spans, text)
        children.each { |child| header.children << child }
        @root.children << header
      end

      def children_to_add(spans, text)
        result = []
        if !spans.empty?
          beginning = text[0...spans.first[:start]]
          em = text[spans.first[:start]...spans.first[:end]]
          ending = text[spans.first[:end]..-1]
          result << Kramdown::Element.new(:text, beginning)
          em_element = Kramdown::Element.new(:em)
          result << em_element
          em_element.children <<  Kramdown::Element.new(:text, em)
          result << Kramdown::Element.new(:text, ending)
        else
          result << Kramdown::Element.new(:text, text)
        end
        result
      end
    end
  end
end
