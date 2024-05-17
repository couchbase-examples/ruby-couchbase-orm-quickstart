module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_user

      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: { error: 'Failed to create user', message: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render json: @user
        else
          render json: { error: 'Failed to update user', message: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      def destroy
        @user = User.find(params[:id])
        if @user.destroy
          render json: { message: 'User deleted successfully' }
        else
          render json: { error: 'Failed to delete user', message: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      def increment_points
        user = User.find(params[:id])
        user.increment(:points, 10) # Increment points by 10
        user.save
        render json: user
      end

      def decrement_points
        user = User.find(params[:id])
        user.decrement(:points, 5) # Decrement points by 5
        user.save
        render json: user
      end

      def create_user_post
        user = User.find(params[:id])
        post = user.posts.create(title: 'New Post', content: 'This is a new post')
        render json: user
      end

      private

      def set_user
        @user = User.find(params[:id])
      rescue Couchbase::Error::DocumentNotFound
        @user = nil
      end

      def user_params
        params.require(:user).permit(:name, :email)
      end
    end
  end
end
