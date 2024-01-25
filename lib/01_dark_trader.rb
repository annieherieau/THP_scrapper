# frozen_string_literal: true
  # Gem PRY : outil de debuggage
  require 'pry' # Appelle la gem Pry : use binding.pry
  # gem Nokogori : scrapping
  require 'nokogiri'
  # gem open-uri : ouvrir une URL
  require 'open-uri'
  #______ keep the code above in each in project files lib/*.rb


# Ouvrir la page >> returns Nokogiri::HTML4::Document
  # rspec ok
def open_page(url)
  page = Nokogiri::HTML(URI.open(url))
  return page
end

# Isoler les éléments HTML 
  # >> returns Hash of arrays {names: [n1, n2], rates: [r1, r2]}
  # rspec ok
def parse_html_elements(page, xpath_elements)
  cryto_data = {
     # array noms de crytos
    names: page.xpath(xpath_elements[:name])
      .map{|node| node.text},
    # array cours des crytos
    rates: crypto_rates = page.xpath(xpath_elements[:rate])
      .map{|node| node.text}
  }
  return cryto_data
end

# Réorganiser ce hash dans un array 
  # returns Array of Hashes = [{name1 : rate1},{name2 : rate2}]
  # rspec ok
def build_scrapping_array(hash)
  array = Array.new
  i=0
  hash[:names].each do |name|
    array.push ({name => hash[:rates][i]})
    i +=1
  end
  puts array[0].values.nil?
  return array
end

# imprimer les résultats
def print_results(array)
  array.each do |hash| 
    hash.each_pair {|k,v| puts "#{k} : #{v}"}
  end
end

# Perform
def dark_trade_scrapper(url)
  # Ouvrir la page
  page = open_page(url)
  
  # xPath des élément à scrapper
  xpath_elements = {
    name: '//a[@class="cmc-table__column-name--name cmc-link"]/@title', 
    rate: '//a[contains(@href, "#markets")]//span'}
  
  # Isoler les éléments HTML (Hash of arrays)
  crypto_data = parse_html_elements(page, xpath_elements)
  puts crypto_data[:rates][0].nil?
  # organiser les données
  return build_scrapping_array(crypto_data)
end


#________ PERFORM
# dark_trade_scrapper("https://coinmarketcap.com/all/views/all/")
print_results(dark_trade_scrapper("https://coinmarketcap.com/all/views/all/"))
