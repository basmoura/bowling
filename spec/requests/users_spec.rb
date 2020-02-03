require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  let(:current_admin) { create(:admin) }

  before do
    post auth_login_path, params: { email: current_admin.email,
                                    password: current_admin.password }
    @token = JSON.parse(response.body)["token"]
  end

  describe 'GET /users' do
    context 'when admin is authorized' do
      before do
        get users_path, headers: { 'Authorization' => @token }
        create_list(:user, 3)
      end

      it 'returns the user' do
        expect(assigns(:users).count).to eq User.count
      end
    end

    context 'when admin is not authorized' do
      it do
        get users_path, headers: { 'Authorization' => "" }
        expect(response.status).to be(401)
      end
    end
  end

  describe 'POST /users' do
    let(:user_attributes) { attributes_for(:user) }

    context 'when admin is authorized' do
      it 'creates a new user' do
        expect do
          post users_path,
            params: { user: user_attributes },
            headers: { 'Authorization' => @token }
        end.to change(User, :count).by(1)
      end
    end

    context 'when admin is not authorized' do
      it 'returns 401' do
        post users_path,
          params: { user_attibutes: user_attributes },
          headers: { 'Authorization' => '' }

        expect(response.status).to be(401)
      end
    end
  end
end
