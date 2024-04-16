require "down"
require "csv"

filepath = "./joker-joker.csv"

CSV.foreach(filepath, headers: :first_row) do |row|
    Down.download("#{row['url']}", destination: "./jokers/#{row['name']}.png")
    p "#{row['name']}: #{row['url']}"
end


