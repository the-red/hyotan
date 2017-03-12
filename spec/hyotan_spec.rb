# frozen_string_literal: true
require 'spec_helper'

RSpec.describe Hyotan do
  it 'has a version number' do
    expect(Hyotan::VERSION).not_to be nil
  end

  it 'cabocha -f3 のXML出力' do
    output = <<~EOS
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
    expect(Hyotan::MyCaboCha.new.run('それは世間が、ゆるさない')).to eq(output)
  end
end
