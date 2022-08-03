load "file_read.rb"

def parse_file(file)
  airline_prefix = ""
  dim_idx = ""
  if File.exist?("#{PATH}/#{file}")
    main_arr = fileRead(file).each_with_index do |line, i|
      if i == 0
        fbl_parse(line)
      elsif i == 1
        flight_id(line)
      elsif i == 2
        point_of_unloading(line)
      elsif i == 3
        airline_prefix = line[0..2]
      elsif line.start_with?("DIM")
        dim_idx = i
        dim_data(line)
      elsif line.start_with?("ULD")
        uld_idx = i
      elsif line.start_with?(airline_prefix)
        consingment_details(line)
      end
    end
  else
    puts "File not found!"
  end
end

private

def fbl_parse(line)
  arr = line.split("/")
  puts "Version of FBL is #{arr[1]}"
end

def flight_id(line)
  arr = line.split("/")
  puts "Message num: #{arr[0]}"
  puts "Carrier code: #{arr[1][0..1]}"
  puts "Flight number: #{arr[1][2..]}"
  puts "Day: #{arr[2][0..1]} / Month: #{arr[2][2..]}"
  puts "Airport code: #{arr[3]}"
  puts "Aircraft registration: #{arr[4]}"
end

def point_of_unloading(line)
  puts "Point of Unloading: #{line[0..2]}"
end

def dim_data(line)
  arr = line.split("/")
  puts "k/l: #{arr[1][0]}, weight: #{arr[1][1..]}"
  puts "Measurement code: #{arr[2][0..2]}"
  measurements = arr[2][3..].split("-")
  puts "Length: #{measurements[0]} Width: #{measurements[1]} Height: #{measurements[2]}"
  puts "Pieces: #{arr[3]}"
end

def consingment_details(line)
  arr = line[4..].split("/")
  arr_data = arr[1][1..].split(".")
  arr_symb = arr_data[0].split(/[0-9]/)
  arr_dig = arr_data[0].split(/[A-Z]/)
  puts "AWB sserial: #{arr[0][0..7]} /
        Airport 1: #{arr[0][8..10]} /
        Airport 2: #{arr[0][11..13]} /
        Shipment description: #{arr[1][0]} /
        number of pieces: #{arr_dig[0]}
        weight: #{arr_dig[1]}
        demension: #{arr_symb.reject(&:empty?)[0]} /
        Description: #{arr[2]}
  "
end
