# difference is ! is destructive and ? would return a boolean depending on the method

# 1. what is != and where should you use it?
# => "not equal" and when comparing two things that are not equal

# 2. put ! before something, like !user_name
# => it would return the opposite of boolean equivalent

# 3. put ! after something, like words.uniq!
# => the method would become destructive and change the original object

# 4. put ? before something
# => don't know

# 5. put ? after something
# => would return true or false depending on the method asked

# 6. put !! before something, like !!user_name
# => look for the truthiness of the method