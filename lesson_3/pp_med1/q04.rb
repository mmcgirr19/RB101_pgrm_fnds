def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

# Difference?
# The first method will push the new_elements to the buffer and essentially overwrite the original buffer
# The second method will not alter the original input_array. It will add new_elements to the input_array.