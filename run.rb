load "parser.rb"
print "input filename: "
file = gets.chomp
puts "++++#{file}++++"
parse_file(file)
