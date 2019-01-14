# rubocop:disable Metricts/BlockLength
# rubocop:disable Style/NestedParenthesizedCalls
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:valid_attributes) { FactoryBot.attributes_for(:post) }
  let(:invalid_attributes) { FactoryBot.attributes_for(:post) }

  context 'with html format' do
    login_user
    let(:post) { FactoryBot.create(:post, user: @user) }

    context 'get requests' do
      describe 'GET #index' do
        it 'returns a success response' do
          get :index, params: {}
          expect(response).to be_success
        end
      end

      describe 'GET #show' do
        it 'returns a success response' do
          get :show, params: { id: post.to_param }
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
          get :edit, params: { id: post.to_param }
          expect(response).to be_success
        end
      end
    end

    context 'post requests' do
      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new Post' do
            expect {
              post :create, params: { post: valid_attributes }
            }.to change(Post, :count).by(1)
          end

          it 'creates a post with user_id' do
            post :create, params: { post: valid_attributes }
            expect(Post.last).to have_attributes(user_id: @user.id)
          end

          it 'create an instance with user_id and ip_code' do
            post :create, params: { post: valid_attributes }
            expect(assigns(:post)).to have_attributes(
              user_id: @user.id, ip_code: '82.54.103.29'
            )
          end

          it 'the created post has a longitude' do
            post :create, params: { post: valid_attributes }
            expect(Post.last.longitude).to be_present
          end

          it 'the longitude is not equal to zero' do
            post :create, params: { post: valid_attributes }
            expect(Post.last.longitude).not_to be(0.0)
          end

          it 'the longitude is not equal to zero' do
            post :create, params: { post: valid_attributes }
            expect(Post.last.location).to be_present
          end

          it 'redirects to the created post' do
            post :create, params: { post: valid_attributes }
            expect(response).to redirect_to(posts_path)
          end
        end

        context 'with invalid params' do
          render_views
          it "returns a success response (i.e. to display the 'new' template)"
            # post :create, params: { post: invalid_attributes }
            # expect(response.status).to eql(200)

          it 'render an alert' 
            # post :create, params: { post: invalid_attributes }
            # expect(controller).to set_flash
        end

        context 'private methods' do 
          it 'replaces the ip with a static ip' do
            post :create, params: { post: valid_attributes }
            expect(request.static_ip_finder).to eql(
              ActionDispatch::Request.my_static_ip
            )
          end
        end
      end
    end


    context 'put requests' do
      describe 'PUT #update' do
        context 'with valid params' do
          let(:new_attributes) {
            FactoryBot.attributes_for(:post, description: 'new description')
          }

          it 'updates the requested post' do
            put :update, params: { id: post, post: new_attributes }
            post.reload
            expect(post.description).to eql('new description')
          end

          it 'redirects to the post' do
            put :update, params: { id: post, post: valid_attributes }
            expect(response).to redirect_to(post)
          end
        end

        context 'with invalid params' do
          it "returns a success response (i.e. to display the 'edit' template)" do
            #post = Post.create! valid_attributes
            put :update, params: { id: post, post: invalid_attributes }
            expect(response.status).to be(302)
          end
        end
      end
    end

    context 'with delete requests' do
      describe 'DELETE #destroy' do
        it 'destroys the requested post' do
          expect { delete :destroy, params: { id: post } }.to change(
            Post, :count
          ).by(-1)
        end

        it 'redirects to the posts list' do
          delete :destroy, params: { id: post.to_param }
          expect(response).to redirect_to(posts_url)
        end
      end
    end
  end

  context 'with json format' do
    let(:user) { FactoryBot.create(:user) }
    let(:post_attributes) { FactoryBot.attributes_for(:post, user: user) }
    let(:valid_base64_image){ Base64.encode64(File.read('spec/controllers/test_image.jpg')) }

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
        before(:each) { request.headers.merge!(authentication_params) }
        it 'not trigger authentication error' do
          expect(
            post :create, params: { post: post_attributes }
          ).to_not have_http_status(401)
        end

        it 'save the post' do
          attributes = {
            picture_path: { file: valid_base64_image },
            original_filename: "original filename",
            filename: 'my filename'
          }
          post_attributes.merge!(attributes)
          expect(
            post :create, params: { post: post_attributes }
          ).to have_http_status(200)
        end
      end
    end
  end
end
