hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], 
        third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'aeiou'

hsh.each do |_, v|
  v.each do |word|
    word.chars.each do |letter|
      puts letter if vowels.include?(letter)
    end
  end
end