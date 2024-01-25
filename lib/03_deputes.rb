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

# scrapping des url des dépités
def get_deputes_urls(url)
  # Ouvrir la page
  page = open_page(url)

  # xPath des élément à scrapper
  xpath_element = '//a[contains(@href, "/deputes/fiche/")]'

  # Isoler les éléments HTML (Hash of arrays)
  deputes_data = page.xpath(xpath_element)

  # array des urls
  deputes_urls = []
  (0...deputes_data.length).each do |i|
    deputes_urls.push({ deputes_data[i].children.text => deputes_data[i].attribute_nodes[0].value })
  end
  deputes_urls
end

# scrapping  pour 1 député >> return Hash
def get_depute_email(url)
  # Ouvrir la page
  page = open_page(url)

  # xPath des élément à scrapper
  xpath_elements = {
    name: '//h1',
    email: '//a[contains(@href, "mailto")]'
  }

  # Isoler les éléments HTML (Hash of arrays)
  first_name = page.xpath(xpath_elements[:name]).text.split[1]
  last_name = page.xpath(xpath_elements[:name]).text.split[2]
  email = page.xpath(xpath_elements[:email]).text.split[1]
  email_perso = page.xpath(xpath_elements[:email]).text.split.last if page.xpath(xpath_elements[:email]).text.split.length > 2

  # returns hash
  depute_email = { first_name:, last_name:, email:, email_perso: }
end

def scrapping_deputes(url_site, url_fiche)
  # collecter les urls des députés
  deputes_urls = get_deputes_urls(url_site).slice(0, 10) # enlever le slice pour tous les députés

  # Array des emails
  deputes_emails = []

  # extraire les urls pour scrapper les emails
  deputes_urls.each do |hash|
    url = url_fiche + hash.values.join.split('/').last.delete('OMC_')
    deputes_emails.push(get_depute_email(url))
  end
  deputes_emails
  # binding.pry
end

# ________ PERFORM
url_site = "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
url_depute = "https://www.assemblee-nationale.fr/dyn/deputes/PA605036"
url_fiche = "https://www.assemblee-nationale.fr/dyn/deputes/"
# get_deputes_urls(url_site)
# get_depute_email("https://www.assemblee-nationale.fr/dyn/deputes/PA605036").first
puts scrapping_deputes(url_site, url_fiche)
