# frozen_string_literal: true

require_relative '../lib/02_mairie_christmas'

town_url = "https://www.annuaire-des-mairies.com/95/avernes.html"
page = open_page(town_url)
xpath_elements = {
    name: '//h1[contains(text(), " - ")]/text()', 
    email: '//td[contains(text(),"@")]/text()'}
#________

describe "open_page(town_url) function" do
  it "returns a Nokogiri::HTML4::Document" do
    expect(open_page(town_url).nil?).to eq(false)
    expect(open_page(town_url).class).to eq(Nokogiri::HTML4::Document)
  end
end

describe "get_townhall_email(town_url) function" do
  it "returns a hash {name => email}" do
    expect(get_townhall_email(town_url)).to eq({"AVERNES"=>"mairie.avernes@orange.fr"})
  end
end
