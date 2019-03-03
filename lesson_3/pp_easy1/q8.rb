flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

p flintstones

# return un-nested
flintstones = ["Fred", "Wilma"]
flintstones.concat(["Barney", "Betty"])
flintstones.concat(["BamBam", "Pebbles"])

p flintstones

# or
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

p flintstones.flatten!