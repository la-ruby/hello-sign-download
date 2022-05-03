require 'hello_sign'

API_KEY = ENV['HELLOSIGN_API_KEY']

def get_total_pages(client)
  list = client.get_signature_requests(page_size: 100)
  list.data["list_info"]["num_pages"]
end

def get_all_requests(client)
  signature_requests = []
  page = 1
  total_pages = get_total_pages(client)

  while page < total_pages + 1
     req = client.get_signature_requests(page_size: 100, page: page)
     signature_requests << req.data["signature_requests"]
     page += 1
  end

  signature_requests.flatten
end

def download_requests(client, requests)
  requests.each do |req|
    begin
      puts "-- Downloading #{req['final_copy_uri']}"
      download = client.get(
        req["final_copy_uri"].gsub('/v3', '')
      )
    rescue StandardError => e
      puts "-- Failed #{e.message}"
      next
    end
    fname = clear_title(req["title"])
    File.open("HelloSign-#{fname}", "wb") do |file|
      file.write(download[:body])
    end
  end
end

def clear_title(str)
  str = str.gsub(/[^\w]/, '_')
  str += '.pdf'
end

client = HelloSign::Client.new(api_key: API_KEY)
download_requests(client, get_all_requests(client))
