# frozen_string_literal: true
require 'cabocha'
require 'happymapper'

module Hyotan
  refine CaboCha::Parser do
    def parse(args)
      tree = super(args)
      tree_xml = tree.toString(CaboCha::FORMAT_XML).force_encoding('utf-8').encode('utf-8')
      tree.hyotan_tree = Hyotan::Tree.parse(tree_xml)
      tree
    end
  end

  refine CaboCha::Tree do
    attr_accessor :hyotan_tree
  end
end
