require "open-uri"
require "nokogiri"
require "csv"

filepath = "articles.csv"

def scraper(url)
    all_articles = []

    html_file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36").read
    html_doc = Nokogiri::HTML.parse(html_file)
    
  
    html_doc.search(".MuiContainer-root.jss95.MuiContainer-maxWidthLg").each do |element|
      article_details = []
      aTag = element.search("a")
      article_details << "https://www.techstars.com#{aTag.attribute("href").value}"
      article_details << element.text.strip
      all_articles << article_details
    end
    all_articles
end

def save_csv(array, filepath)
    CSV.open(filepath, "a+") do |csv|
      array.each do |element|
        csv << [element]
      end
    end
end


save_csv(scraper("https://www.techstars.com/newsroom"), filepath)