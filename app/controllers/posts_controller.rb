class PostsController < ApplicationController
  binding.pry
  before_action :authenticate_user!, except: [:landing, :index]
  before_action :set_post, only: [:create, :update]
  before_action :find_post, only: [:show, :edit, :destroy]

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
    binding.pry
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
      binding.pry
      @post = Post.new(post_params)
      @post.user_id = current_user.id
    end

    def post_params
      binding.pry
      params.require(:post).permit(:description, :user_id)
    end
end