module PostsHelper
  def server_date
  	DateTime.now.utc
  end
  def post_owner?(user)
  	binding.pry
  	self.user == user
  end    
end
