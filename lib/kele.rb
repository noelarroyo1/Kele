require 'httparty'
require 'pp'
require 'json'
require 'rest-client'
require './lib/roadmap'

class Kele
  include HTTParty
  include Roadmap

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

    pp JSON.parse response.body
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(
      "#{@base_url}/mentors/#{mentor_id}/student_availability",
      headers: { "authorization" => @auth_token }
    )

    json_object = JSON.parse response.body
    puts json_object
  end

  def get_messages(n = nil)
    url = "#{@base_url}/message_threads/"

    if !n.nil?
      url = "#{@base_url}/message_threads/?page=#{n}"
    end

    response = self.class.get(
      url,
      headers: { "authorization" => @auth_token }
    )

    json_object = JSON.parse response.body
    pp json_object
  end

  def create_message(
    sender,
    recipient_id,
    token = nil,
    subject = nil,
    stripped_text
  )

    message = {
      "sender": sender,
      "recipient_id": recipient_id,
      "token": token,
      "subject": subject,
      "stripped-text": stripped_text
    }

    response = RestClient.post "#{@base_url}/messages",
    message, headers: { "authorization" => @auth_token }

    puts response
  end
end
