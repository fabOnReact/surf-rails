Dir[File.join(Rails.root, 'lib', 'core_ext','*.rb')].each do |file|
	binding.pry
	require file
end
#{|l| require l}