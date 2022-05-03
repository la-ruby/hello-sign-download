require 'json'
require 'time'
require 'debug'

tot = Dir["data/files/*.pdf"].length
counter = 1
Dir.each_child('./data/files') do |file|
  if file =~ /error/
    puts "#{counter}/#{tot} Skip"
    counter += 1
    next
  end
  srid = file.sub('.pdf','')
  created_at = JSON.parse(File.open("./data/signature_requests/#{srid}").read)['created_at']
  iso8601 = Time.at(created_at).utc.strftime("%F")
  if file =~ /error/ || File.exist?("./data/dated_files/#{iso8601}_#{srid}.pdf")
    puts "#{counter}/#{tot} Skip #{iso8601}_#{srid}.pdf"
    counter += 1
    next
  end
  puts "#{counter}/#{tot} #{iso8601}_#{srid}.pdf"
  `cp ./data/files/#{srid}.pdf ./data/dated_files/#{iso8601}_#{srid}.pdf`
  debugger
  counter += 1
end

