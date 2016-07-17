module PassionsHelpers
  def post_to_passions(token, data=nil)
    default_passions = {
      "passions": [
        {"name": "TestOne"}
      ]
    }

    if data
      post "/passions", data, {'Authorization': token}
    else
      post "/passions", default_passions, {'Authorization': token}
    end
  end
end
