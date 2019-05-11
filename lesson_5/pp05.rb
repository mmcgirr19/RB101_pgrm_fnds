munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# p munsters.sum{|k, v| v["age"] if v["gender"] == "male"}

total_age = 0
munsters.each_value do |age_male|
  if age_male["gender"] == "male"
    total_age += age_male["age"]
  end
end

puts total_age