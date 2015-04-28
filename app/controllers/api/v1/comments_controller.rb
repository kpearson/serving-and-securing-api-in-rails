class Api::V1::CommentsController < ApplicationController
  respond_to :json, :xml

  before_action :authenticate

  def show
    respond_with Comment.find(params[:id])
  end

  def index
    respond_with Comment.all
  end

  def create
    respond_with Comment.create(comment_params)
    # respond_with :api, :v1, Comment.create(comment_params)
  end

  def update
    respond_with Comment.update(params[:id], comment_params)
  end

  def destroy
    respond_with Comment.destroy(params[:id])
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, _|
      ApiKey.exists?(token: token)
    end
  end


  # def authenticate
  #   authenticate_or_request_with_http_basic("Please Authnticate") do |email, password|
  #     author = Author.find_by(email: email)
  #
  #     return true if author && author.authenticate(password)
  #
  #     head :unauthorized
  #   end
  # end

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
