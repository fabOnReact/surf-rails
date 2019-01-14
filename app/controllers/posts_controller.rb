class PostsController < ApplicationController
  # rubocop:disable Style/SingleLineMethods
  # rubocop:disable Layout/EmptyLineBetweenDefs
  # rubocop:disable Metrics/LineLength 
  before_action :set_post, only: [:create]
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def landing; end
  def index; @posts = Post.all.newest; end
  def show; end
  def new; @post = Post.new; end
  def edit; end

  def create
    if params[:post][:picture_path]['file']
      picture_path_params = params[:picture][:picture_path]
      tempfile = Tempfile.new('fileupload')
      uploaded_file = ActionDispatch::Http::UploadedFile.new(
        tempfile: tempfile,
        filename: picture_path_params['filename'],
        original_filename: picture_path_params['original_filename']
      )
      params[:picture][:picture_path] = uploaded_file 
    end

    @post = Post.new(description: 'test', picture: params[:picture])

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render :new, alert: 'An error occurred and your post was not saved' }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
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
    @post.assign_attributes(user_id: current_user.id, ip_code: request.static_ip_finder)
  end

  def post_params   
    params.require(:post).permit(:description, :longitude, :latitude, :picture, :location)
  end
end
