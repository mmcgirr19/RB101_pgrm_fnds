hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

#(all)
arr = []
hsh.map do |k, v|
  arr << v[:colors].each {|x| x.capitalize!}
  arr.push(v[:size].upcase!)
end

p arr

#(color of fruit and size of vegetable)
hsh.map do |_, v|
  if v[:type] == 'fruit'
    v[:colors].map do |color|
      color.capitalize
    end
  elsif v[:type] == 'vegetable'
    v[:size].upcase
  end
end