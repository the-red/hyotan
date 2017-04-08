# frozen_string_literal: true
require 'hyotan/version'
require 'hyotan/cabocha'

module Hyotan
  class Token
    include HappyMapper

    tag 'tok'
    attribute :id, Integer
    attribute :feature, String
    content :surface
  end

  class Chunk
    include HappyMapper

    tag 'chunk'
    attribute :id, Integer
    attribute :link, Integer
    attribute :rel, String
    attribute :score, Float
    attribute :head, Integer
    attribute :func, Integer
    has_many :tokens, Token
  end

  class Tree
    include HappyMapper

    tag 'sentence'
    has_many :chunks, Chunk
  end
end
