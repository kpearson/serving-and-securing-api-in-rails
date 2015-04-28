class Api::V1::ArticlesController < ApplicationController
  respond_to :json, :xml

  before_action :authenticate

  def show
    respond_with Article.find(params[:id])
  end

  def index
    respond_with Article.all
  end

  def create
    respond_with Article.create(article_params)
  end

  def update
    respond_with Article.update(params[:id], article_params)
  end

  def destroy
    respond_with Article.destroy(params[:id])
  end

  private

  def authenticate
    authenticate_or_request_with_http_basic("Please authnticate") do |email, password|d
      author = Author.find_by(email: email)

      return true if author && author.authenticate(password)

      head :unauthorized
    end
  end

  def article_params
    require(:article).permit(:title, :body)
  end
end
