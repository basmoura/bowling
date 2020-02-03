require 'rails_helper'

RSpec.describe 'Admins', type: :request do
  describe 'POST admin' do
    context 'when has valid attributes' do
      let(:admin_attributes) { attributes_for(:admin) }

      it 'creates a new Admin' do
        expect do
          post admins_path, params: { admin: admin_attributes }
        end.to change(Admin, :count).by(1)
      end
    end

    context 'when has invalid attributes' do
      let(:admin_invalid_attributes) { attributes_for(:admin, email: nil) }

      it 'returns 422' do
        post admins_path, params: { admin: admin_invalid_attributes }

        expect(response.status).to eq 422
      end
    end
  end
end
