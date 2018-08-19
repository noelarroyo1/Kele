require 'httparty'
require 'pp'
require 'json'

class Kele
  include HTTParty

  def initialize(email, password)
    @base_url = 'https://www.bloc.io/api/v1'

    response = Kele.post(
      "#{@base_url}/sessions",
      body: { email: email, password: password }
    )

    if response && response["auth_token"]
      @auth_token = response["auth_token"]
      puts "#{email} has sucessfully logged in"
    else
      puts "Login invalid"
    end
  end

  def get_me
    response = self.class.get(
      "#{@base_url}/users/me",
      headers: { "authorization" => @auth_token }
    )

    JSON.parse response.body
  end
end
