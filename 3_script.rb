require 'hello_sign'
require 'debug'

client = HelloSign::Client.new(api_key: ENV['HELLOSIGN_API_KEY'])
counter = 1
tot = Dir["data/signature_requests/*"].length
Dir.each_child('./data/signature_requests') do |srid|
  puts "skip exist #{srid}" if File.exist?("./data/files/#{srid}")
  next if File.exist?("./data/files/#{srid}")
  puts "Downloading #{counter}/#{tot} #{srid}"
  file_bin = client.signature_request_files :signature_request_id => srid
  open("./data/files/#{srid}", "wb") do |file|
    file.write(file_bin)
  end
  counter += 1
  sleep 0.1
end

