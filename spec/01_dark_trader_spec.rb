# frozen_string_literal: true

require_relative '../lib/01_dark_trader'

url ="https://coinmarketcap.com/all/views/all/"
page = open_page(url)
xpath_elements = {
  name: '//a[@class="cmc-table__column-name--name cmc-link"]/@title', 
  rate: '//a[contains(@href, "#markets")]//span'}
crypto_data = parse_html_elements(page, xpath_elements)
#___________

describe "open_page(url) function" do
  it "returns a Nokogiri::HTML4::Document" do
    expect(open_page(url).nil?).to eq(false)
    expect(open_page(url).class).to eq(Nokogiri::HTML4::Document)
  end
end

describe "parse_html_elements(page, xpath_elements) function" do
  it "returns a hash of arrays" do
    expect(parse_html_elements(page, xpath_elements).class).to eq(Hash)
    expect(parse_html_elements(page, xpath_elements)[:names][0] ).to eq("Bitcoin")
    expect(parse_html_elements(page, xpath_elements)[:rates][0].nil?).to eq(false)
  end
end

describe "build_scrapping_array(hash) function" do
  it "returns a array of hash" do
    expect(build_scrapping_array(crypto_data).length > 3).to eq(true)
    expect(build_scrapping_array(crypto_data)[0].keys ).to eq(Bitcoin)
    expect(build_scrapping_array(crypto_data)[0].values.nil? ).to eq(false)
  end
end