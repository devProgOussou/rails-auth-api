class SessionsController < ApplicationController
  def signup
    user = User.new(email: params[:email], password: params[:password])
    if user.save
      token = encode_user_data({user_data: user.id})
      render json: {token: token}, status: 201
    else
      render json: {error: "User not found or invalid credentials"}, status: 401
    end
  end

  def login
    begin
      user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = encode_user_data({user_data: user.id})
      render json: {token: token}
    else
      render json: {error: "User not found or invalid credentials"}, status: 401
    end
    rescue => exception
      puts exception
    end
  end
end