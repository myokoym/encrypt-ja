# encoding: utf-8
require 'rspec'
require 'rack/test'

MY_APP = Rack::Builder.parse_file('config.ru').first

include Rack::Test::Methods
def app
  MY_APP
end

describe "encrypt-ja" do
  context "root" do
    it "last response ok?" do
      get '/'
      last_response.ok? == true
    end
  end

  context "encrypt (HTTP POST)" do
    it "tanuki" do
      post '/encrypt', {:text => "五時に屋上",
                        :algorithm => "tanuki"}
      last_response.ok? == true
      last_response.body.force_encoding("utf-8").should =~ /た五時たに屋た上/
    end
  end

  context "encrypt (HTTP GET)" do
    it "tanuki" do
      get '/encrypt', {:text => "五時に屋上",
                        :algorithm => "tanuki"}
      last_response.ok? == true
      last_response.body.force_encoding("utf-8").should =~ /た五時たに屋た上/
    end
  end
end
