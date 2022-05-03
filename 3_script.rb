require 'hello_sign'
require 'debug'

Dir.each_child('./data/signature_requests') do |filename|
  puts filename
end

# client = HelloSign::Client.new(api_key: ENV['HELLOSIGN_API_KEY'])
# file_bin = client.signature_request_files :signature_request_id => 'ffaab17218bd96c0a4bb7e3954aa443cbb77a700'
# open("data/files/finalCopy.pdf", "wb") do |file|
#   file.write(file_bin)
# end
