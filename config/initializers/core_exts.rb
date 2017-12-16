Dir[File.join(Rails.root, 'lib', 'core_ext', 'action_dispatch', 'http','*.rb')].each {|l| require l}
