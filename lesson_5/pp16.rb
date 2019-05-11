#attempt
#first randomize selection of 32 characters between numbers and letters
#second, break up by 8-4-4-4-12 with hypen
#third make a string

def new_uuid
  uuid_arr = []
    ('a'..'f').each {|char| uuid_arr << char}
    (0..9).each {|num| uuid_arr << num.to_s}

    uuid = " "
    uuid_arr.sample

end

#school's answer
def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ""
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end