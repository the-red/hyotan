# frozen_string_literal: true
require 'hyotan/version'
require 'hyotan/cabocha'

module Hyotan
  class Relation
    # TODO: すべての係り受けを返すrelations配列を作る
    attr_reader :from, :to, :surface

    def initialize(chunk_from, chunk_to)
      @chunk_from = chunk_from
      @chunk_to   = chunk_to

      @surface = ''
      chunk_from.tokens.each do |token|
        @surface << token.surface
      end
      chunk_to.tokens.each do |token|
        @surface << token.surface
      end
    end

    def to_s
      @surface
    end

    # 特定の品詞を除去
    def delete_token(key, value)
      @chunk_from.delete_if do |token|
        token[key] == value
      end
      @chunk_to.delete_if do |token|
        token[key] == value
      end
    end
  end

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

    def to_s
      self.surface
    end

    def category
      self.feature
    end
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

    def self.parse(xml, options = {})
      super(xml, options)

      puts('hogehoge!')
    end

    def relations
      @relations = []
      # 全てのチャンクに対して
      chunks.each do |chunk|
        # linkが繋がっていなければ次のチャンクへ
        next if chunk.link.negative?
        # リンク元
        chunk_from = chunk
        # リンク先
        chunk_to = chunks[chunk.link]
        # 係り受け1つ分
        relation = Relation.new(chunk_from, chunk_to)
        @relations << relation
      end
      @relations
    end

  end
end
