# frozen_string_literal: true
require 'hyotan/version'
require 'hyotan/cabocha'

module Hyotan
  class Feature
    # featureの9つの要素を返すメソッド9種類
    # MeCabが参考になるかも
    # 品詞,品詞細分類1,品詞細分類2,品詞細分類3,活用形,活用型,原形,読み,発音
  end

  class Token
    include HappyMapper
    # Featureクラスのを返す？このクラスに実装しちゃう？
    attr_accessor :category, :subcategory1, :subcategory2, :subcategory3,
                  :katuyou, :katsuyou2, :genkei, :yomikaga, :hatsuon

    def 動詞?;end
    def 読点?;end

    # TODO: -n1/-n2 オプションの"ne"属性も含める
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
