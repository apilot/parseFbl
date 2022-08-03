PATH = "./files"
def fileRead(file)
  File.readlines("#{PATH}/#{file}").map(&:chomp)
end
