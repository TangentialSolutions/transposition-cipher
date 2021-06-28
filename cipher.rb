# this should, you know, be secret
KEY = 8.freeze

def encode(string, key)
  # hash keys are the column numbers
  # column 1 + column 2 + ... + column KEY is encoded string
  columns = {}

  column_index = 1
  (0..(string.length-1)).each do |string_index|
    columns[column_index.to_s.to_sym] ||= ""
    columns[column_index.to_s.to_sym] += string[string_index]

    # reset every KEY times, starting at the beginning of the next row
    column_index = (column_index == key) ? 1 : (column_index + 1)
  end

  columns.values.join
end

def decode(string, key)
  column_count = (string.length.to_f / key).ceil
  columns = {}

  column_index = 1
  (0..(string.length-1)).each do |string_index|
    columns[column_index.to_s.to_sym] ||= ""
    columns[column_index.to_s.to_sym] += string[string_index]

    # reset every KEY times, starting at the beginning of the next row
    column_index = (column_index == column_count) ? 1 : (column_index + 1)
  end

  columns.values.join
end

encoded = encode("Common sense is not so common.", KEY)
puts "encoded: #{encoded}"
puts "decoded: #{decode(encoded, KEY)}"
