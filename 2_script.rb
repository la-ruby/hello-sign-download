require 'hello_sign'
require 'debug'

client = HelloSign::Client.new(api_key: ENV['HELLOSIGN_API_KEY'])
list = client.get_signature_requests(page_size: 99)
total_pages = list.data["list_info"]["num_pages"]
puts "total_pages #{total_pages}"
page = 29
while page < total_pages + 1
  puts "page #{page}"
  req = client.get_signature_requests(page_size: 98, page: page)
  req.data["signature_requests"].each do |sr|
    debugger if sr['signature_request_id'].empty?
    puts "Tracing sr['signature_request_id'] #{sr['signature_request_id']}"
    File.open("data/signature_requests/#{sr['signature_request_id']}", "w") do |file|
      file.write(sr.to_json)
    end
  end
  page += 1
end
