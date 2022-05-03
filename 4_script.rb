require 'json'
require 'time'
require 'debug'

tot = Dir["data/files/*.pdf"].length
counter = 1
Dir.each_child('./data/files') do |file|
  srid = file.sub('.pdf','')
  created_at = JSON.parse(File.open("./data/signature_requests/#{srid}").read)['created_at']
  iso8601 = Time.at(created_at).utc.iso8601
  if File.exist?("./data/dated_files/#{iso8601}_#{srid}.pdf")
    puts "#{counter}/#{tot} Skip #{iso8601}_#{srid}.pdf"
    counter += 1
    next
  end
  puts "#{counter}/#{tot} #{iso8601}_#{srid}.pdf"
  counter += 1
end

