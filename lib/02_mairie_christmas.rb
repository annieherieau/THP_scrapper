# frozen_string_literal: true

# Gem PRY : outil de debuggage
require 'pry' # Appelle la gem Pry : use binding.pry
# gem Nokogori : scrapping
require 'nokogiri'
# gem open-uri : ouvrir une URL
require 'open-uri'
# ______ keep the code above in each in project files lib/*.rb

# Ouvrir la page >> returns Nokogiri::HTML4::Document
# rspec ok
def open_page(url)
  Nokogiri::HTML(URI.open(url))
end

# Isoler les éléments HTML
# >> returns Hash of arrays {names: [n1, n2], rates: [r1, r2]}
# rspec ok
# imprimer les résultats
def print_results(array)
  array.each do |hash|
    hash.each_pair { |k, v| puts "#{k} : #{v}" }
  end
end

# Perform pour 1 mairie >> return Hash
# rspec ok
def get_townhall_email(url)
  # Ouvrir la page
  page = open_page(url)

  # xPath des élément à scrapper
  xpath_elements = {
    name: '//h1[contains(text(), " - ")]/text()',
    email: '//td[contains(text(),"@")]/text()'
  }

  # Isoler les éléments HTML (Hash of arrays)
  townhall_name = page.xpath(xpath_elements[:name]).text.split(' - ').first
  townhall_email = page.xpath(xpath_elements[:email]).text

  { townhall_name => townhall_email }
end

# scrapping des url des mairies
# rspec Ok
def get_townhall_urls(departement_url)
  # Ouvrir la page
  page = open_page(departement_url)

  # xPath des élément à scrapper
  xpath_element = '//table[@class="Style20"]//a'

  # Isoler les éléments HTML (Hash of arrays)
  depart_data = page.xpath(xpath_element)
  towns_data = []
  (0...depart_data.length).each do |i|
    towns_data.push({ depart_data[i].children.text => depart_data[i].attribute_nodes[1].value[1..] })
  end

  towns_data
end

# spapping de toutes les mairies du département
# rspec Ok
def townhall_scrapper(departement_url, site_url)
  # collecter les data des villes du département
  towns_data = get_townhall_urls(departement_url)
  # Array des emails des mairies
  towns_emails = Array.new

  # extraire les urls pour scrapper les emails
  towns_data.each do |hash|
    url = site_url+hash.values.join
    towns_emails.push(get_townhall_email(url))
  end
  towns_emails
end

# ______ PERFORM
url_mairie = "https://www.annuaire-des-mairies.com/95/avernes.html"
url_site =  "https://annuaire-des-mairies.com"
url_depart1 = "https://annuaire-des-mairies.com/val-d-oise.html"

# 1 mairie
# puts get_townhall_email(url_mairie)

# urls des mairies du département
# puts get_townhall_urls(url_depart1,url_site )

# email des mairies du département
print_results(townhall_scrapper(url_depart1, url_site))
