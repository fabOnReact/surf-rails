module PostsHelper
  def action_group
    case action_name
      when 'new' || 'edit' then 'first_group'
      when 'index' then 'second_group'
    end
  end
end
