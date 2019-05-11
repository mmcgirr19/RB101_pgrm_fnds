arr = ['10', '11', '9', '7', '8']

integers = arr.map {|x| x.to_i}

integers.sort! {|x,y| y <=> x}

puts integers