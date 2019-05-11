flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.each {|value[i]| puts i if value.to_s.start_with?("Be")}