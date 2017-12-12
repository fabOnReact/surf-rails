require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  describe '#link_path' do
    it 'return the correct path' do
      allow(controller).to receive(:action_name).and_return('new')
      expect(link_path).to eql(posts_path)
    end
  end
end
