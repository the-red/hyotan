# frozen_string_literal: true
require 'spec_helper'
using Hyotan

RSpec.describe Hyotan do
  before do
    @tree = CaboCha::Parser.new.parse('それは世間が、ゆるさない')
  end

  it 'has a version number' do
    expect(Hyotan::VERSION).not_to be nil
  end

  it 'cabocha -f3 のXML出力' do
    f3_xml = @tree.toString(CaboCha::FORMAT_XML).force_encoding('utf-8').encode('utf-8')

    expect(f3_xml).to eq(<<~EOS)
    <sentence>
     <chunk id="0" link="2" rel="D" score="-0.744433" head="0" func="1">
      <tok id="0" feature="名詞,代名詞,一般,*,*,*,それ,ソレ,ソレ">それ</tok>
      <tok id="1" feature="助詞,係助詞,*,*,*,*,は,ハ,ワ">は</tok>
     </chunk>
     <chunk id="1" link="2" rel="D" score="-0.744433" head="2" func="3">
      <tok id="2" feature="名詞,一般,*,*,*,*,世間,セケン,セケン">世間</tok>
      <tok id="3" feature="助詞,格助詞,一般,*,*,*,が,ガ,ガ">が</tok>
      <tok id="4" feature="記号,読点,*,*,*,*,、,、,、">、</tok>
     </chunk>
     <chunk id="2" link="-1" rel="D" score="0.000000" head="5" func="6">
      <tok id="5" feature="動詞,自立,*,*,五段・サ行,未然形,ゆるす,ユルサ,ユルサ">ゆるさ</tok>
      <tok id="6" feature="助動詞,*,*,*,特殊・ナイ,基本形,ない,ナイ,ナイ">ない</tok>
     </chunk>
    </sentence>
    EOS
  end

  it 'CaboCha::Tree#hyotan_tree' do
    expect(@tree.hyotan_tree.class).to eq Hyotan::Tree
  end

  it 'Hyotan::Tree#chunks' do
    expect(@tree.hyotan_tree.chunks.class).to eq Array
  end

  it 'Hyotan::Tree#chunks[0]' do
    expect(@tree.hyotan_tree.chunks[0].class).to eq Hyotan::Chunk
  end

  it 'Hyotan::Chunk#id' do
     expect(@tree.hyotan_tree.chunks[0].id).to eq(0)
  end

  it 'Hyotan::Chunk#link' do
     expect(@tree.hyotan_tree.chunks[0].link).to eq(2)
  end

  it 'Hyotan::Chunk#rel' do
     expect(@tree.hyotan_tree.chunks[0].rel).to eq('D')
  end

  it 'Hyotan::Chunk#score' do
     expect(@tree.hyotan_tree.chunks[0].score).to eq(-0.744433)
  end

  it 'Hyotan::Chunk#head' do
     expect(@tree.hyotan_tree.chunks[0].head).to eq(0)
  end

  it 'Hyotan::Chunk#func' do
     expect(@tree.hyotan_tree.chunks[0].func).to eq(1)
  end

  it 'Hyotan::Chunk#tokens' do
     expect(@tree.hyotan_tree.chunks[0].tokens.class).to eq(Array)
  end

  it 'Hyotan::Chunk#tokens[0]' do
     expect(@tree.hyotan_tree.chunks[0].tokens[0].class).to eq(Hyotan::Token)
  end

  it 'Hyotan::Token#id' do
     expect(@tree.hyotan_tree.chunks[0].tokens[0].id).to eq(0)
  end

  it 'Hyotan::Token#feature' do
     expect(@tree.hyotan_tree.chunks[0].tokens[0].feature).to eq('名詞,代名詞,一般,*,*,*,それ,ソレ,ソレ')
  end

  it 'Hyotan::Token#surface' do
     expect(@tree.hyotan_tree.chunks[0].tokens[0].surface).to eq('それ')
  end
end
