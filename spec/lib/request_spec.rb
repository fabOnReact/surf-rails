require 'rails_helper'
require 'core_ext/action_dispatch/http/request'

describe ActionDispatch::Request do 

  subject { ActionDispatch::Request }

  before(:each) do 
    @request = subject.new({})
    @request.remote_ip=('0.0.0.0')
  end

  describe ':static_ip_finder' do
    it 'replaces the dynamic with the static ip' do
      expect(@request.static_ip_finder).to eql(subject.my_static_ip)
    end

    it 'replaces the ip when it is 127.0.0.1' do
      @request.remote_ip=('127.0.0.1')
      expect(@request.static_ip_finder).to eql(subject.my_static_ip)
    end

    it 'returns the original static ip' do
      allow(@request).to receive(:remote_ip).and_return('178.1.6.22')
      expect(@request.static_ip_finder).to eql('178.1.6.22')
    end
  end
end
