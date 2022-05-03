require 'hello_sign'
require 'debug'

client = HelloSign::Client.new(api_key: ENV['HELLOSIGN_API_KEY'])
counter = 1
tot = Dir["data/signature_requests/*"].length
Dir.each_child('./data/signature_requests') do |srid|
  if File.exist?("./data/files/#{srid}.pdf")
    puts "#{counter}/#{tot} Skip #{srid}"
    counter += 1
    next
  end
  puts "#{counter}/#{tot} Downloading #{srid}"
  begin
    file_bin = client.signature_request_files :signature_request_id => srid
  rescue HelloSign::Error::Conflict => err
    file_bin = nil
    open("./data/files/#{srid}.error.txt", "wb") do |file|
      file.write("HelloSign::Error::Conflict")
    end    
  end
  if file_bin
    open("./data/files/#{srid}.pdf", "wb") do |file|
      file.write(file_bin)
    end
  end
  counter += 1
  sleep 2.4
end

