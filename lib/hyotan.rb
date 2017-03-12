# frozen_string_literal: true
require 'hyotan/version'
require 'cabocha'

module Hyotan
  class MyCaboCha
    def run(sentence)
      parser = CaboCha::Parser.new
      tree = parser.parse(sentence)
      output = tree.toString(CaboCha::FORMAT_XML).force_encoding('utf-8').encode('utf-8')
      output
    end
  end
end
