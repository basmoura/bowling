require 'rails_helper'

RSpec.describe 'Lanes', type: :request do
  let(:current_admin) { create(:admin) }
  let(:bowling_house) { create(:bowling_house, admin: current_admin) }

  before do
    post auth_login_path, params: { email: current_admin.email,
                                    password: current_admin.password }
    @token = JSON.parse(response.body)["token"]
  end

  describe 'GET /lanes' do
    context 'when admin is authorized' do
      before do
        get bowling_house_lanes_path(bowling_house), headers: { 'Authorization' => @token }
        create_list(:lane, 3, bowling_house: bowling_house)
      end

      it 'returns the lanes' do
        expect(assigns(:lanes).count).to eq Lane.count
      end
    end

    context 'when admin is not authorized' do
      it do
        get bowling_house_lanes_path(bowling_house), headers: { 'Authorization' => "" }
        expect(response.status).to be(401)
      end
    end
  end

  describe 'POST /lanes' do
    let(:lane_attributes) { attributes_for(:lane) }
    context 'when admin is authorized' do
      it 'creates a new lane' do
        expect do
          post bowling_house_lanes_path(bowling_house),
               params: { lane: lane_attributes },
               headers: { 'Authorization' => @token }
        end.to change(Lane, :count).by(1)
      end
    end

    context 'when admin is not authorized' do
      it 'returns 401' do
        post bowling_house_lanes_path(bowling_house),
             params: { lane: lane_attributes },
             headers: { 'Authorization' => '' }

        expect(response.status).to be(401)
      end
    end
  end

  describe 'PATCH /lanes' do
    let(:lane) { create(:lane, bowling_house: bowling_house) }

    context 'when admin is authorized' do
      it 'change status from open to maintenance' do
        patch bowling_house_lane_path(bowling_house.id, lane),
              params: { lane: { status: 'maintenance' } },
              headers: { 'Authorization' => @token }
        expect(lane.reload.status).to eq 'maintenance'
      end
    end

    context 'when admin is not authorized' do
      it 'returns 401' do
        patch bowling_house_lane_path(bowling_house.id, lane),
              params: { lane: { status: 'maintenance' } },
              headers: { 'Authorization' => '' }
        expect(response.status).to be(401)
      end
    end
  end
end
