require 'rails_helper'

RSpec.describe Admin, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to have_many(:bowling_houses) }
end
