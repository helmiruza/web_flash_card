class HaiwanEndMalayImporter
 def self.import
    deck = Deck.create(name: "haiwan_eng_malay")

    File.open("db/haiwan.txt", "r").each_line do |line|
      line = line.chomp.split("\t")
      Card.create(header: "Translate below English word to Malay", deck_id: deck.id, question: line[0], answer: line[1].downcase)
    end
 end
end

class UsCapDictImporter
 def self.import
    deck = Deck.create(name: "us_capitals_dict")

    File.open("db/us-capitals.txt", "r").each_line do |line|
      line = line.chomp.split("\t")
      Card.create(header: "Provide US Capitals below", deck_id: deck.id, question: line[0], answer: line[1].downcase)
    end
 end
end

HaiwanEndMalayImporter.import
UsCapDictImporter.import