require 'rails_helper'
require 'core_ext/action_dispatch/http/request'

describe ActionDispatch::Request do 
  before(:each) do 
    @request = ActionDispatch::Request.new({})
    @request.remote_ip=('0.0.0.0')
  end

  describe ':get_remote_ip' do
    it 'return the ip' do
      expect(@request.get_remote_ip).to eql('0.0.0.0')
    end
  end

  describe ':ip_finder' do
    it 'replaces the dynamic with the static ip' do
      expect(@request.ip_finder).to eql('98.236.166.116')
    end

    it 'returns the original static ip' do
      allow(@request).to receive(:remote_ip).and_return('178.1.6.22')
      expect(@request.ip_finder).to eql('178.1.6.22')
    end
  end
end