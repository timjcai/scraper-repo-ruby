require "open-uri"
require "nokogiri"
require "csv"

filepath = "joker.csv"

def scraper(url)
    scraped_array = []
    html_file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36").read
    html_doc = Nokogiri::HTML.parse(html_file)

    # # Find all img elements with a lazy loading attribute
    # lazy_images = html_doc.css('img[data-src]')

    # # Extract the source URLs
    # image_urls = lazy_images.map { |img| img['data-src'] }

    # # Preload the images
    # image_urls
    # # image_urls.each do |image_url|
    # #     open(image_url) { |f| f.read }
    # # end

  
    html_doc.search("//tr//td//a//img").each do |element|
     scraped_array << element['data-src']
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


save_csv(scraper("https://balatrogame.fandom.com/wiki/Jokers"), "joker.csv")