require 'rails_helper'

RSpec.describe Frame, type: :model do
  let(:game) { create(:game) }
  let(:user) { create(:user) }

  describe 'when is strike' do
    context 'and is first throw' do 
      let(:frame) { create(:frame, :strike, game: game, user: user) }

      it { expect(frame.strike).to be_truthy }
      it { expect(frame.status).to eq 'ended' }
      it { expect(frame.points).to eq 10 }
    end

    context 'when is second throw' do
      before do
        create(:frame) { create(:frame, :strike, game: game, user: user) }
      end

      let(:frame) { create(:frame, game: game, user: user, second_pins_dropped: 0) }

      context 'and is first ball' do
        it do
          total_score = user.last_ended_frame.points + frame.first_pins_dropped + 10
          expect(frame.points).to eq total_score
        end
      end

      context 'and is second ball' do
        it do
          frame.update(second_pins_dropped: 6)
          total_score = user.last_ended_frame.points + \
                        frame.first_pins_dropped + \
                        frame.second_pins_dropped + 20

          expect(frame.points).to eq total_score
        end
      end
    end

    context 'and is the tenth frame' do
      before do
        create_list(:frame, 9, game: game, user: user, status: 'ended')
        @tenth_frame = create(:frame, :strike, game: game, user: user)
      end

      context 'when is second try' do
        it do
          @tenth_frame.update(third_pins_dropped: 5)
          expect(@tenth_frame.points).to eq @tenth_frame.points + 15
        end
      end
    end
  end
end
