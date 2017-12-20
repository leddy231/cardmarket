require "json"
require "firebase"
base_uri = "https://steffescardmarket.firebaseio.com/"
secret = "JVLuEMqHrzfFprfeG5zs9XwPADL011zSTpKJopFi"
$firebase = Firebase::Client.new(base_uri, secret)
url = "https://api.magicthegathering.io/v1/cards?set=xln"
cards = ""
open(url + "&rarity=rare", "rb") do |data|
	cards = JSON.parse(data.read)
end

open(url + "&rarity=mythic_rare", "rb") do |data|
	cards["cards"] += JSON.parse(data.read)["cards"]
end

cards["cards"].each do |c|
	if !c["colors"]
		c["color"] = "grey"
	else
		if c["colors"].size > 1
			c["color"] = "gold"
		else
			c["color"] = c["colors"][0].downcase
		end
	end
end

cards["cards"].uniq!{|card| card["colors"]}
size = cards["cards"].size
cards["cards"].each.with_index do |c, index|
	path = File.dirname(__FILE__) + "/public/cards/" + c["id"] +".png"
	if !File.file?(path)
		puts "Downloading image (#{index}/#{size})"
		open(c["imageUrl"], "rb") do |data|
			File.open(path, "wb") do |file|
				file.write data.read
			end
		end
	end
	c["imageUrl"] = "/cards/" + c["id"] +".png" 

	mana = c["manaCost"]
	if mana
		finalMana = ""
		for symbol in mana.split("}")
			finalMana += '<i class="ms ms-cost ms-symbol"></i>'
			symbol.gsub!("{", "")
			finalMana.gsub!("symbol", symbol)
		end
		c["manaCost"] = finalMana
	end

	c["price"] = rand(1..300)
	c["id"] = index
end



#cards["cards"].sort!{|uno, dos| uno["colors"] <=> dos["colors"]}
#puts j.inspect
$firebase.set("/", cards)
#puts  $firebase.get("cards").body
