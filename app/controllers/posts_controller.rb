class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_updated_post_invalid

  def show
    post = Post.find(params[:id])

    render json: post
  end

  def update
    post = Post.find(params[:id])

    post.update!(post_params)

    render json: post
  end

  private

  def render_updated_post_invalid(invalid)
    render json: { errors: invalid.record.errors}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: { errors: "a kind of Hash" }, status: :not_found
  end

  def post_params
    params.permit(:category, :content, :title)
  end
end
