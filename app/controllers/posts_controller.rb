class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:landing, :index]
  before_action :set_post, only: [:create]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def landing
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        flash[:alert] = 'An error occurred and your post was not saved' 
        format.html { render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
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
    def find_post
      @post = Post.find(params[:id])
    end

    def set_post     
      @post = Post.new(post_params)
      binding.pry
      @post.assign_attributes(user_id: current_user.id, ip_code: request.ip_finder)
      #@post.set_ip(request.ip_finder)
    end

    def post_params   
      params.require(:post).permit(:description)
    end
end