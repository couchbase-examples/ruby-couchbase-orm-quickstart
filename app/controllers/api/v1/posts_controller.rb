module Api
  module V1
    class PostsController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_post
      def index
        @posts = Post.all
        render json: @posts
      end

      def show
        @post = Post.find(params[:id])
        render json: @post
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      def create
        @post = Post.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: { error: 'Failed to create post', message: @post.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
          render json: @post
        else
          render json: { error: 'Failed to update post', message: @post.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      def destroy
        @post = Post.find(params[:id])
        if @post.destroy
          render json: { message: 'Post deleted successfully' }
        else
          render json: { error: 'Failed to delete post', message: @post.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
      end

      def append_content
        post = Post.find(params[:id])
        post.append(:content, ' additional text') # Append additional text to content
        post.save
        render json: post
      end

      def prepend_content
        post = Post.find(params[:id])
        post.prepend(:content, 'additional text ') # Prepend additional text to content
        post.save
        render json: post
      end

      private

      def set_post
        @post = Post.find(params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @post = nil
      end

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
