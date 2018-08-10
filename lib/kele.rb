require 'httparty'
require 'pp'

class Kele
  include HTTParty

  def initialize(email, password)
    @auth = { email: email, password: password }
    @url = 'https://www.bloc.io/api/v1'
  end

  def post
    # options = { basic_auth: @auth }
    self.class.post("#{@url}/sessions", @auth)
  end
end
