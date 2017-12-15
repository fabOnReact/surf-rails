module PostsHelper
  def link_path
    case action_name
      when action_name = 'index'
      else 
        posts_path        
    end
  end     
end
