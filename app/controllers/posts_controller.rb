require 'upload/cache'
require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'

class PostsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  acts_as_token_authentication_handler_for User
  skip_before_action :verify_authenticity_token
  before_action :set_post, only: [:create]
  before_action :find_posts, only: [:index]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def edit; end
  def show; end
  
  def new
    @post = Post.new
  end

  def index
    respond_to do |format|
      format.html
      format.json do 
        decorate_posts
        render json: @posts, status: 200, location: posts_path 
      end
    end
  end

  def create
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render :new, alert: 'An error occurred and your post was not saved' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @post.flagged = true if is_admin?
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
  def set_post
    @post = Post.new(post_params)
    @post.assign_attributes(
      user_id: current_user.id,
    )
  end

  def find_posts
    @posts = Post.newest.limit(30).paginate(page: params[:page], per_page: params[:per_page])
  end

  def decorate_posts
    @posts = @posts.map do |post| 
      PostSerializer.new(post).serializable_hash[:data][:attributes]
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def is_admin?
    params[:password] == ENV['ADMIN_KEY'] && params[:password].present?
  end

  def post_params   
    params.require(:post).permit(:description, :longitude, :latitude, :location, :likes, :flagged, :reported, :flag_reason, video: {}, picture: {})
  end
end
