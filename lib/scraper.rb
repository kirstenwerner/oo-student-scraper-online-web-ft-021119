require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    student_cards = doc.css('.student-card')
    student_cards.map do |student|
      name = student.css("h4").text
      location = student.css("p").text
      url = student.css("a").first.attributes["href"].value
      {:name => name, :location => location, :profile_url => url}
    end
  end     

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hrefs = doc.css('.social-icon-container').css('a')
    profile_info = {} 
    hrefs.each do |link|
      url = link.attributes.first[1].value
      if url.include?('twitter.com')
        profile_info[:twitter] = url 
      elsif url.include?('linkedin.com')
        profile_info[:linkedin] = url 
      elsif url.include?('github.com')
        profile_info[:github] = url 
      else 
        profile_info[:blog] = url
      end 
    end
    
    profile_quote = doc.css('.profile-quote').text
    bio = doc.css('.description-holder').css('p').text.strip
    
    profile_info[:bio] = bio 
    profile_info[:profile_quote] = profile_quote
    
    profile_info
  end

end

