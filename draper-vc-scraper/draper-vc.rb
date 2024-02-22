require "open-uri"
require "nokogiri"
require "csv"

filepath = "companies.csv"

def scraper(url)
    scraped_array = []
    html_file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36").read
    html_doc = Nokogiri::HTML.parse(html_file)
  
    html_doc.search(".companyname-maindisplay").each do |element|
      scraped_array << element.text.strip
    end
    scraped_array
end

def save_csv(array, filepath)
    CSV.open(filepath, "a+") do |csv|
      array.each do |element|
        csv << [element]
      end
    end
end


save_csv(scraper("https://www.draper.vc/companies"), "companies.csv")