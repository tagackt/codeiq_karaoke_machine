# coding: utf-8

class KaraokeMachine
  def initialize(melody)
    @melody = melody
#    puts "元キー\t" + @melody
  end

  def transpose(amount)

    #キーをカンマ付き数値に変換する（縦棒、半角スペースはそのままでカンマ付きに）
    #カンマ付きなのは、二ケタの数値が出現するため
    melody_num = @melody.gsub(/[A-G]#|[A-G]| |\|/, 
      "C" => ",0",
      "C#" => ",1",
      "D" => ",2",
      "D#" => ",3",
      "E" => ",4" ,
      "F" => ",5",
      "F#" => ",6",
      "G" => ",7",
      "G#" => ",8",
      "A" => ",9",
      "A#" => ",10",
      "B" => ",11",
      " " => ", ",
      "|" => ",|"
      )

    #  最初の文字列に , が余分に入っているので、除く
    if melody_num.length > 0 then
      melody_num = melody_num[1...melody_num.length]
    end

#    puts "カンマ付き数値キー：" + melody_num

    #キー移動
    #配列で取り出し、キーを変更する
    splited_melody_nums = melody_num.split(",").collect {|num| if num == " " || num == "|" then num else num.to_i + amount end}
    #11（シ）よりも大きくなった場合、0(ド)に戻ってキー移動するため、また、0（ド）よりも小さくなった場合、11（シ）に戻ってキー移動するため
    splited_melody_nums.collect! {|num| if num.to_i >= 12 || num.to_i < 0 then num.to_i % 12 else num end}
#    puts "キー変更後:" + splited_melody_nums.join(",")

    #数値をキーに置換する
    return_melody = splited_melody_nums.join(",").gsub(/1[0-1]|[0-9]| |\|/,
      "0" => "C",
      "1" => "C#",
      "2" => "D",
      "3" => "D#",
      "4" => "E",
      "5" => "F",
      "6" => "F#",
      "7" => "G",
      "8" => "G#",
      "9" => "A",
      "10" => "A#",
      "11" => "B",
      " " => " ",
      "|" => "|"
      )
    #カンマがついているので除く    
    return_melody.delete!(",")

#    puts "置換後" + return_melody

    return_melody

   end
end

describe KaraokeMachine do
  it "メロディ無し" do
    melody = ""
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(0)).to eq answer
  end

  # ここから下のコメントを外していって、テストを全部パスさせてください！

  it "変更無し" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = melody
    expect(KaraokeMachine.new(melody).transpose(0)).to eq answer
  end

  it "2上げる" do
    melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
    answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
    expect(KaraokeMachine.new(melody).transpose(2)).to eq answer
  end

   it "7上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "G A B C |B A G   |B C D E |D C B   |G   G   |G   G   |GGAABBCC|B A G   "
     expect(KaraokeMachine.new(melody).transpose(7)).to eq answer
   end
  
   it "1下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(KaraokeMachine.new(melody).transpose(-1)).to eq answer
   end
  
   it "7下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "F G A A# |A G F   |A A# C D |C A# A   |F   F   |F   F   |FFGGAAA#A#|A G F   "
     expect(KaraokeMachine.new(melody).transpose(-7)).to eq answer
   end
  
   it "1オクターブ上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(12)).to eq answer
   end
  
   it "1オクターブ下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(-12)).to eq answer
   end
  
   it "14上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(KaraokeMachine.new(melody).transpose(14)).to eq answer
   end
  
   it "13下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(KaraokeMachine.new(melody).transpose(-13)).to eq answer
   end
  
   it "2オクターブ上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(24)).to eq answer
   end
  
   it "2オクターブ下げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = melody
     expect(KaraokeMachine.new(melody).transpose(-24)).to eq answer
   end
  
   it "26上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(KaraokeMachine.new(melody).transpose(26)).to eq answer
   end
  
   it "25上げる" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(KaraokeMachine.new(melody).transpose(-25)).to eq answer
   end
  
   it "6上げる(メロディはF#から開始)" do
     melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
     answer = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     expect(KaraokeMachine.new(melody).transpose(6)).to eq answer
   end
  
   it "6下げる(メロディはF#から開始)" do
     melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
     answer = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     expect(KaraokeMachine.new(melody).transpose(-6)).to eq answer
   end
  
   it "連続してtransposeを呼び出す" do
     melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
     karaoke = KaraokeMachine.new(melody)
  
     answer = melody
     expect(karaoke.transpose(0)).to eq answer
  
     answer = "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
     expect(karaoke.transpose(2)).to eq answer
  
     answer = "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "
     expect(karaoke.transpose(-1)).to eq answer
   end
end
