require 'rails_helper'

RSpec.describe 'Games', type: :request do
  let(:current_admin) { create(:admin) }
  let(:bowling_house) { create(:bowling_house, admin: current_admin) }
  let(:lane) { create(:lane, bowling_house: bowling_house) }

  before do
    post auth_login_path, params: { email: current_admin.email,
                                    password: current_admin.password }
    @token = JSON.parse(response.body)["token"]
  end

  describe 'GET /games' do
    context 'when admin is authorized' do
      before do
        get lane_games_path(lane), headers: { 'Authorization' => @token }
        create_list(:game, 3, lane: lane)
      end

      it 'returns the games' do
        expect(assigns(:games).count).to eq Game.count
      end
    end

    context 'when admin is not authorized' do
      it do
        get lane_games_path(lane), headers: { 'Authorization' => "" }
        expect(response.status).to be(401)
      end
    end
  end

  describe 'POST /games' do
    let(:game_attributes) { attributes_for(:game) }
    context 'when admin is authorized' do
      it 'creates a new game' do
        expect do
          post lane_games_path(lane),
               params: { game: game_attributes },
               headers: { 'Authorization' => @token }
        end.to change(Game, :count).by(1)
      end
    end

    context 'when admin is not authorized' do
      it 'returns 401' do
        post lane_games_path(lane),
             params: { game: game_attributes },
             headers: { 'Authorization' => '' }

        expect(response.status).to be(401)
      end
    end
  end

  describe 'PATCH /games' do
    let(:game) { create(:game, lane: lane) }

    context 'when admin is authorized' do
      it 'change status from live to ended' do
        patch lane_game_path(lane.id, game),
              params: { game: { status: 'ended', end_at: '2020-02-03T18:44:13.539Z' } },
              headers: { 'Authorization' => @token }
        expect(game.reload.status).to eq 'ended'
      end
    end

    context 'when admin is not authorized' do
      it 'returns 401' do
        patch lane_game_path(lane.id, game),
              params: { lane: { status: 'maintenance' } },
              headers: { 'Authorization' => '' }
        expect(response.status).to be(401)
      end
    end
  end
end
