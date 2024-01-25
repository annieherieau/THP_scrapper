# frozen_string_literal: true
# Gem PRY : outil de debuggage
require 'pry' # Appelle la gem Pry : use binding.pry
# gem Nokogori : scrapping
require 'nokogiri'
# gem open-uri : ouvrir une URL
require 'open-uri'
#______ keep the code above in each in project files lib/*.rb

# Ouvrir la page >> returns Nokogiri::HTML4::Document
def open_page(url)
  page = Nokogiri::HTML(URI.open(url))
  return page
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

# Perform pour 1 mairie >> return Hash
def get_townhall_email(url)
  # Ouvrir la page
  page = open_page(url)
  
  # xPath des élément à scrapper
  xpath_elements = {
    name: '//h1[contains(text(), " - ")]/text()', 
    email: '//td[contains(text(),"@")]/text()'}
  
  # Isoler les éléments HTML (Hash of arrays)
  townhall_name = page.xpath(xpath_elements[:name]).text.split(' - ').first
  townhall_email = page.xpath(xpath_elements[:email]).text

  return {townhall_name => townhall_email}
end


#______ PERFORM 
# url_mairie = "https://www.annuaire-des-mairies.com/95/avernes.html"
# puts get_townhall_email(url_mairie)
