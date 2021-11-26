require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'
puts("Hello world")
url = "https://index.minfin.com.ua/labour/salary/min/"
html = URI.open(url){ |result| result.read }
document = Nokogiri::HTML(html) # Open web address with Nokogiri
headers = []
document.xpath('//tr/th').each do |th|
  headers << th.text
end
puts(headers)
rows = []
document.xpath('//tr').each_with_index do |row, i|
  rows[i] = {}
  row.xpath('td').each_with_index do |td, j|
    rows[i][j] = td.text
  end
end
puts(rows)

CSV.open('salary.csv', 'w') do |csv|
     csv << headers
     rows.each { |salary| csv << salary.values }
end

