require 'upload/cache'
require 'core_ext/actionpack/lib/action_controller/metal/strong_parameters'
# require 'posts/index_serializer'

class PostsController < ApplicationController
  ActionController::Parameters.include(Parameters::Location)

  acts_as_token_authentication_handler_for User
  skip_before_action :verify_authenticity_token
  before_action :set_post, only: [:create]
  before_action :decorate_posts, only: [:index]
  before_action :set_picture, only: [:create]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def edit; end
  def show; end

  def new
    @post = Post.new
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: @posts, status: :created, location: api_v1_posts_path }
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

  def liked
    params[:post][:liked]
  end

  def update
    @post.favorite.push(current_user.id) if liked == true
    @post.favorite.delete(current_user.id) if liked == false
    @post.favorite.uniq!

    respond_to do |format|
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
  def set_picture
    cache = Upload::Cache.new(params[:post][:picture])
    @post.picture = PictureUploader.new
    @post.picture.store!(Upload::Image.new(cache))
  end

  def set_post
    @post = Post.new(post_params)
    @post.assign_attributes(
      user_id: current_user.id,
      ip_code: request.static_ip_finder
    )
  end

  def set_posts
    # @posts = Post.near(params.gps, 50, units: :km) if params.location?
    # @posts = Post.limit(30) if no_results 
    @posts = Post.newest.paginate(page: params[:page], per_page: params[:per_page])
  end

  def decorate_posts
    set_posts
    @posts = @posts.map do |post| 
      new_post = PostSerializer.new(post).serializable_hash[:data][:attributes]
      new_post[:location][:forecast][:tideChart] = new_post[:location][:forecast].delete(:tide) if new_post[:location][:forecast]
      new_post
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def no_results; @posts.nil? || @posts.empty?; end

  def post_params   
    params.require(:post).permit(:description, :longitude, :latitude, :location, :likes, picture: {})
  end
end
