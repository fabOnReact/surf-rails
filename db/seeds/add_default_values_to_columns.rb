locations = Location.where(last_camera_at: nil)
locations.each do |location|
  location.update(last_camera_at: location.updated_at)
end

cameras = Camera.where(last_post_at: nil)
cameras.each do |camera|
  camera.update(last_post_at: camera.updated_at)
end
