# frozen_string_literal: true

# Gem PRY : outil de debuggage
require 'pry' # Appelle la gem Pry : use binding.pry
# gem Nokogori : scrapping
require 'nokogiri'
# gem open-uri : ouvrir une URL
require 'open-uri'
# ______ keep the code above in each in project files lib/*.rb

# ouvrir une url
page = Nokogiri::HTML(URI.open("ton_url_a_scrapper.com"))

# Array des éléments HTML à scrapper en utilisant leur XPath
all_emails_links = page.xpath('/mettre_ici_le_XPath')

# recurer les liens
page.xpath('//a')

# recuperer les <h1>
page.xpath('//h1')

# récuperer les liens sous <h1>, même s'ils sont inclus
# dans un paragraphe, lui-même imbriqué dans une div
page.xpath('//h1//a')

# récupérer les liens situés DIRECTEMENT sous un titre h1 (sans élément intermédiaire)
page.xpath('//h1/a')

# récupérer TOUS les éléments HTML situés DIRECTEMENT sous un titre h1
page.xpath('//h1/*')

# récupérer le lien ayant l'id email situé sous un titre h1 de classe primary
page.xpath('//h1[@class="primary"]/a[@id="email"]')

# récupérer tous les liens dont le href contient le mot "mailto"
page.xpath('//a[contains(@href, "mailto")]')

# récupérer le texte de chaque lien ? Il faut parcourir l'array et extraire le .text de chaque élément HTML
all_emails_links.each do |email_link|
  puts email_link.text # ou n'importe quelle autre opération de ton choix ;)
end

# récupérer le texte du href d'un élément HTML
email_link['href']
