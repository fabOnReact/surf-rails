# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe Users::RegistrationsController, type: :controller do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  context 'with a valid oauth token' do
    describe 'POST #create' do
      it 'create an oauth user' do
        google_auth = instance_double("google_auth")
        allow(GoogleAuth).to receive(:new).and_return(google_auth)
        allow(google_auth).to receive(:authorized?).and_return(true)
        post :create, params: { user: { email: 'test@email.com', accessToken: '123' } }, format: :json
        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status 201
        expect(json[:email]).to eql 'test@email.com'
        expect(json[:token]).to_not be ""
      end
    end
  end

  context 'without a valid oauth token' do
    describe 'POST #create' do
      it 'create an oauth user' do
        post :create, params: { user: { email: 'test@email.com', accessToken: '123' } }, format: :json
        json = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status 422
        expect(json[:password]).to include "can't be blank"
      end
    end
  end
end
