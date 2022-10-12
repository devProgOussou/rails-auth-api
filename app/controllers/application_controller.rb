class ApplicationController < ActionController::API
  SECRET = Figaro.env.TOKEN_SECRET!
  EXPIRATION = Figaro.env.TOKEN_EXPIRATION.to_i
  
  def authentication
    decode_data = decode_user_data(request.headers["token"])
    user_data = decode_data[0]["user_id"] unless !decode_data
    user = user.find(user_data&.id)

    if user
      return true
    else
      render json: {error: "User not found or invalid credentials"}, status: 401
    end
  end

  def encode_user_data(payload)
    JWT.encode(payload, SECRET, "HS256")
  end

  def decode_user_data(token)
    begin
      data = JWT.decode(token, SECRET, true, {algorithm: "HS256"})
      return data
    rescue => exception
      puts exception
    end
  end
end
