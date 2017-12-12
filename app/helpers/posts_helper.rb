module PostsHelper
  def link_path
    case action_name
      when 'new' || 'edit' then posts_path
    end
  end    
end
