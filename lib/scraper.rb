require 'nokogiri'
require 'open-uri'

class Scraper
  BFRODB = "https://www.bfro.net/GDB/"
  BFRO = "https://www.bfro.net"

  def self.scrape_bfro
    html = open(BFRODB)
    doc = Nokogiri::HTML(html)
    doc.css("table.countytbl").css(".cs b").each do |state|
    url = state.css("a").attr("href").value
    new_state = state.css("a").text
      if new_state != ""
    the_state = State.new(new_state, url)
    the_state.save
      end
    end
  end

  def self.scrape_reports(state_input)
    html = open(BFRO + state_input.url)
    doc = Nokogiri::HTML(html)
    state_input.reports = doc.css(".spaced").text.gsub!(/[\n\t]/,"").split("\r")
  end

end
