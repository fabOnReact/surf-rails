# rubocop:disable Metricts/BlockLength
# rubocop:disable Style/NestedParenthesizedCalls
require 'rails_helper'
require 'json'

RSpec.describe PostsController, type: :controller do
  let(:valid_attributes) { FactoryBot.attributes_for(:post, latitude: 1, longitude: 1) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:post, latitude: 1, longitude: 1) }
  let(:valid_base64_image) { Base64.encode64(File.read('spec/assets/test_image.jpg')) }

  login_user

  context 'with web authentication' do
    let(:new_post) { FactoryBot.create(:post, user: @user, latitude: 1, longitude: 1) }
    let(:location) { FactoryBot.create(:location, latitude: 1, longitude: 1) }

    context 'get requests' do
      describe 'GET #index' do
        it 'returns a success response' do
          get :index, params: {}
          expect(response).to be_success
        end
      end
      describe 'GET #show' do
        it 'returns a success response' do
          get :show, params: { id: new_post.to_param }
          expect(response).to be_success
        end
      end

      describe 'GET #new' do
        it 'returns a success response' do
          get :new, params: {}
          expect(response).to be_success
        end
      end

      describe 'GET #edit' do
        it 'returns a success response' do
          get :edit, params: { id: new_post.to_param }
          expect(response).to be_success
        end
      end
    end

    context 'post requests' do
      describe 'POST #create' do
        context 'with valid params' do
          before(:each) do
            valid_attributes[:picture] = { file: valid_base64_image, name: 'test.png' }
          end

          it 'creates a new Post' do
            expect {
              post :create, params: { post: valid_attributes }
            }.to change(Post, :count).by(1)
          end
        end
      end
    end


    context 'put requests' do
      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) {
            FactoryBot.attributes_for(:post, description: 'new description', latitude: 1, longitude: 1)
          }

          it 'updates the requested post' do
            put :update, params: { id: new_post, post: new_attributes }
            new_post.reload
            expect(new_post.description).to eql('new description')
          end

          it 'redirects to the post' do
            put :update, params: { id: new_post, post: valid_attributes }
            expect(response).to redirect_to(new_post)
          end
        end

        context 'with invalid params' do
          it "returns a success response (i.e. to display the 'edit' template)" do
            #post = Post.create! valid_attributes
            put :update, params: { id: new_post, post: invalid_attributes }
            expect(response.status).to be(302)
          end
        end
      end
    end

    context 'with delete requests' do
      describe 'DELETE #destroy' do
        it 'destroys the requested post' do
          new_post
          expect { delete :destroy, params: { id: new_post } }.to change(
            Post, :count
          ).by(-1)
        end

        it 'redirects to the posts list' do
          delete :destroy, params: { id: new_post.to_param }
          expect(response).to redirect_to(posts_url)
        end
      end
    end
  end

  context 'with json token' do
    let(:user) { FactoryBot.create(:user) }
    # let(:post_attributes) { FactoryBot.attributes_for(:post, user: user) }

    describe 'POST #create' do
      let(:authentication_params) do
        {
          'X-User-Email': user.email,
          'X-User-Token': user.authentication_token,
          'Accept': 'application/json',
          'Content-Type': 'multipart/form-data;'
        }
      end

      context 'with authentication headers' do
        before(:each) do
          request.headers.merge!(authentication_params)
          valid_attributes[:picture] = { file: valid_base64_image, name: 'test.png' }
        end

        it 'not trigger authentication error' do
          expect(post :create, params: { post: valid_attributes }).to_not have_http_status(401)
        end

        it 'save the post' do
          expect(post :create, params: { post: valid_attributes }).to have_http_status(201)
        end

        it 'store the picture' do
          post :create, params: { post: valid_attributes }
          json = JSON.parse(response.body, symbolize_names: true)
          expect(json[:picture][:url]).to match "http://localhost:3000/uploads/post/"
        end
      end
    end
  end
end
