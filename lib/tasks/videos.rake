posters = { 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/bronte-min.mp4' => 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/bronte-poster.png', 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/costline-min.mp4' => 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/costline-poster.png', 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/seaside-min.mp4' => 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/seaside-poster.png', 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/surfer-min.mp4' => 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/surfer-poster.png' }
# posts = Post.where("video->>'url' = 'https://surfcheck.s3.eu-central-1.amazonaws.com/videos/surfer-min.mp4'")
posts = Post.where.not(video: nil)
posts.each.with_index do |post|
  url = post.video["url"]
  post.video = {"url" => post.video["url"], "poster" => posters[url]}
  post.save
end

