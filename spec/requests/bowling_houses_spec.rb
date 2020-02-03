require 'rails_helper'

RSpec.describe 'BowlingHouse', type: :request do
  let(:current_admin) { create(:admin) }

  before do
    post auth_login_path, params: { email: current_admin.email,
                                    password: current_admin.password }
    @token = JSON.parse(response.body)["token"]
  end

  describe 'GET /bowling_houses' do
    context 'when admin is authorized' do
      before do
        get bowling_houses_path, headers: { 'Authorization' => @token }
        create_list(:bowling_house, 3, admin: current_admin)
      end

      it 'returns the bowling houses' do
        expect(assigns(:bowling_houses).count).to eq BowlingHouse.count
      end
    end

    context 'when admin is not authorized' do
      it do
        get bowling_houses_path, headers: { 'Authorization' => "" }
        expect(response.status).to be(401)
      end
    end
  end

  describe 'POST /bowling_houses' do
    context 'when admin is authorized' do
      let(:bowling_house_attributes) { attributes_for(:bowling_house) }

      it 'creates a new bowling house' do
        expect do
          post bowling_houses_path,
            params: { bowling_house: bowling_house_attributes },
            headers: { 'Authorization' => @token }
        end.to change(BowlingHouse, :count).by(1)
      end
    end

    context 'when admin is not authorized' do
      let(:bowling_house_attributes) { attributes_for(:bowling_house) }

      it 'returns 401' do
        post bowling_houses_path,
          params: { bowling_house: bowling_house_attributes },
          headers: { 'Authorization' => '' }

        expect(response.status).to be(401)
      end
    end
  end
end
