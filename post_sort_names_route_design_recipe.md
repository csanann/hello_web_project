#file: recipe.md

## (POST/sort_names) Route Design Recipe

1. Design the Route Signature

HTTP Method: POST
Path: /sort-names
Body Parameters: names (a comma-separated string of names)

2. Design the Response
Response: A comma-separated string of names, sorted alphabetically.

200 ok status will be used to show that everything worked as expected when send a list of names/string to the route> we are creating a route that sorts names alphabetically.

===>will skip this part, since we're not dealing with html response yet/may not encounter 404 Not Found<==

Replace the below with your own design.
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->

<html>
  <head></head>
  <body>
    <h1>Post title</h1>
    <div>Post content</div>
  </body>
</html>
—-----
<!-- EXAMPLE -->
<!-- Response when the post is not found: 404 Not Found -->

<html>
  <head></head>
  <body>
    <h1>Sorry!</h1>
    <div>We couldn't find this post. Have a look at the homepage?</div>
  </body>
</html>
==============
3. Write examples

Expected response:

#Request:
POST /sort-names
Body: names=Joe,Alice,Zoe,Julia,Kieran

#Expected response:
Alice,Joe,Julia,Kieran,Zoe
Response for 200 OK
---------------------
#Request:
GET /posts?id=276278
Body: (missing or empty names parameter)
#Expected response:
Status: 400 Bad Request
Body: "Error: names parameter is missing or empty."

4. Encode as Tests Examples
=# file: spec/integration/app_spec.rb

require "spec_helper"
require "rack/test"
require "app"
===> starting a new test group for the route and includes methods for testing app
describe "Sort Names Route" do
  include Rack::Test::Methods
 defines a method app that returns a new instance for class Application to test
  let(:app) { Application.new }

===> defines a test case to check with 200k and expected test names by sending a post request to the route with parameter+ ,
    it "returns 200 OK with the sorted list of names" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

      response.status==>200
      response.body =>"Alice,Joe,Julia,Kieran,Zoe
    end

    it "returns 400 Bad Request when names parameter is missing or empty" do
      response = post("/sort-names", names: "")

      response.status=> 400
      response.body => "Error: names parameter is missing or empty."
    end

end

5. implement the route

get '/' do
 > welcome to the home page!
end

get '/greet/:name' do
> "Hello, params[:name] !"
end

post "/sort-names" do
 #check if parameter is either missing or empty?
  #if either is true>error display
  if params[:names].nil? || params[:names].empty?
    status 400
    "Error: names parameter is missing or empty."
  else
  #it retrieves the parameter 'names' from params hash,then split , into an array
    names = params[:names].split(",").sort
    #join each individual name back together after sorted the names
    names.join(",")
  end
end
