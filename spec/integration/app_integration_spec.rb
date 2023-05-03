#file: spec/integration/app_spec.rb 

require "./spec/spec_helper"
require "rack/test"
require '/Users/chayadasansiriwong/Desktop/csanann/Projects/hello_web_project/app.rb'

RSpec.describe "Sort Names Route" do
  include Rack::Test::Methods

  let(:app) { Application.new}

  context "Post to /sort-names" do
    it "returns 200 OK with the sorted list of names" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end

    it "returns 400 Bad Request when names parameter is missing or empty" do
      response = post("/sort-names", names: "")

      expect(response.status).to eq(400)
      expect(response.body).to eq("Error: names parameter is missing or empty.")
    end
  end
end