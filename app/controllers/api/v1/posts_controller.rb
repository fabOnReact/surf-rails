class Api::V1::PostsController < PostsController
  before_action :decorate_posts, only: [:index]
  
  private
  def decorate_posts
    set_posts
    @posts = @posts.map do |post| 
      PostSerializer.new(post).serializable_hash[:data][:attributes]
    end
  end
end
