module Roadmap
  def get_roadmap(chain_id)
    response = self.class.get(
      "#{@base_url}/roadmaps/#{chain_id}",
      headers: { "authorization" => @auth_token }
    )

    json_object = JSON.parse response.body
    puts json_object
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get(
      "#{@base_url}/checkpoints/#{checkpoint_id}",
      headers: { "authorization" => @auth_token }
    )

    json_object = JSON.parse response.body
    puts json_object
  end
end
