require 'rails_helper'

RSpec.describe Lane, type: :model do
  it { is_expected.to define_enum_for(:status).with_values([:open, :maintenance]) }
  it { is_expected.to belong_to(:bowling_house) }
end
