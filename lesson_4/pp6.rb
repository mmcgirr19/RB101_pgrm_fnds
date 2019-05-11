flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.collect! do |name|
  name[0,3]
end