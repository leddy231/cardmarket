require 'sinatra'
require 'firebase'
# require "./verifier"
# $verifier = FirebaseIDTokenVerifier.new(id)
require "json"
require "firebase"
base_uri = "https://steffescardmarket.firebaseio.com/"
secret = "JVLuEMqHrzfFprfeG5zs9XwPADL011zSTpKJopFi"
$firebase = Firebase::Client.new(base_uri, secret)
@firebase = $firebase

get "/item/*" do
  @id = params["splat"][0]
  data = $firebase.get("/cards/#{@id}").body
  @name = data["name"]
  @price = data["price"]
  @color = data["color"]
  erb :cartItem, :layout => false
end

get "/" do
	erb :home
end

get "/products" do
	erb :products
end

get '/exit' do
  Process.kill('TERM', Process.pid)
end

not_found do
  status 404
  "Ya broke it"
end


# def log(text)
# 	$firebase.push("logs", text)
# end
#
# def verifyUser(token)
# 	begin
# 		key = FirebaseIDTokenVerifier.retrieve_and_cache_jwt_valid_public_keys[0]
# 		decoded = $verifier.decode(token, key)
# 		return decoded[0]
# 	rescue
# 		return false
# 	end
# end
#
# def cancel(id)
# 	table = $firebase.get("users/#{id}/table").body
# 	if table
# 		section, row, seat = table.split("-")
# 		oldTableBooked = $firebase.get("sections/#{section}/#{row}/#{seat}").body
# 		if oldTableBooked && oldTableBooked == id
# 			$firebase.update("sections/#{section}/#{row}", {"#{seat}" => false})
# 		end
# 		$firebase.update("users/#{id}/", {"table" => false})
# 	end
# end
#
# post '*' do
# 	request.body.rewind
# 	@body = JSON.parse(request.body.read)
# 	pass
# end
#
# get "/" do
# 	redirect to("/index")
# end
#
# post "/rename" do
# 	name = @body["name"]
# 	user = verifyUser(@body["token"])
# 	if user
# 		id = user["user_id"]
# 		$firebase.set("users/#{id}/name", name)
# 	end
# end
#
# post "/cancel" do
# 	user = verifyUser(@body["token"])
# 	if user
# 		id = user["user_id"]
# 		cancel(id)
# 	end
# end
#
# post "/book" do
# 	table = @body["table"]
# 	user = verifyUser(@body["token"])
# 	if user
# 		id = user["user_id"]
# 		section, row, seat = table.split("-")
# 		isUsed = $firebase.get("sections/#{section}/#{row}/#{seat}").body
# 		if !isUsed
# 			cancel(id)
# 			$firebase.set("users/#{id}/table", table)
# 			$firebase.set("sections/#{section}/#{row}/#{seat}", id)
# 		end
# 	end
# end
#
# get "/tables" do
# 	erb :tables, :layout => false
# end
#
#
#
# get "/rules" do
# 	erb :rules
# end
#
# get "/booking" do
# 	erb :booking
# end
#
# get "/spinner" do
# 	erb :spinner
# end



# post "/admin" do
# 	#send(params[:time])
# end
#
# get "/admin/*" do
# 	token = params['splat'][0]
# 	ip = request.ip
# 	if !Tokens.any?{|tok| tok[0] == token && tok[1] == ip}
# 		redirect to("/index")
# 		break
# 	end
#
# 	html = ''
# 	content = ''
# 	File.open(File.dirname(__FILE__) + "/index.html", "rb") do |file|
# 		html = file.read
# 	end
# 	File.open(File.dirname(__FILE__) + "/sites/adminaccess.html", "rb") do |file|
# 		content = file.read
# 	end
# 	html.gsub!("CONTENT", content)
# 	html
# end
#
# post "/adminpass" do
# 	pass = params["password"]
# 	if pass == AdminPass
# 		token = (0...50).map{('a'..'z').to_a.sample}.join
# 		Tokens << [token, request.ip]
# 		redirect to("/admin/#{token}")
# 	else
# 		redirect to("/index")
# 	end
# end
