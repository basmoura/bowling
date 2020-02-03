require 'rails_helper'

RSpec.describe Game, type: :model do
  it { is_expected.to validate_presence_of(:start_at) }
  it { is_expected.to define_enum_for(:status).with_values([:live, :ended]) }
  it { is_expected.to belong_to(:lane) }

  describe 'validate presence of end_at if status is ended' do
    let(:game) { create(:game, status: 'ended') }

    it { expect(game).to validate_presence_of(:end_at).on(:update) }
  end
end
