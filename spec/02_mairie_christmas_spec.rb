# frozen_string_literal: true

require_relative '../lib/02_mairie_christmas'

town_url1= "https://www.annuaire-des-mairies.com/95/avernes.html"
town_url2 = "https://annuaire-des-mairies.com/35/montauban-de-bretagne.html"
page = open_page(town_url1)
xpath_elements = {
    name: '//h1[contains(text(), " - ")]/text()', 
    email: '//td[contains(text(),"@")]/text()'}
#________

describe "open_page(town_url) function" do
  it "returns a Nokogiri::HTML4::Document" do
    expect(open_page(town_url1).nil?).to eq(false)
    expect(open_page(town_url1).class).to eq(Nokogiri::HTML4::Document)
  end
end

describe "get_townhall_email(town_url) function" do
  it "returns a hash {name => email}" do
    expect(get_townhall_email(town_url1)).to eq({"AVERNES"=>"mairie.avernes@orange.fr"})
    expect(get_townhall_email(town_url2)).to eq({"MONTAUBAN-DE-BRETAGNE"=>"accueil@mairie-montaubandebretagne.fr"})
  end
end
