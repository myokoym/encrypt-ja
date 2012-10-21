# encoding: utf-8
require 'sinatra'
require 'haml'

get "/" do
  haml :index
end

post "/encrypt" do
  @encrypted_text = encrypt
  @http_get_url = http_get_url
  haml :index
end

get "/encrypt" do
  @encrypted_text = encrypt
  @http_get_url = http_get_url
  haml :index
end

private
def encrypt
  result = ""

  case params[:algorithm]
  when "tanuki"
    result = tanuki(params[:text])
  end

  result
end

def tanuki(text)
  text.gsub(/(.{2})/) {|match| "#{match}た" }
end

def http_get_url
  "#{url}?#{URI.encode_www_form(params)}"
end
