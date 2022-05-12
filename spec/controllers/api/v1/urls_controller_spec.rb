# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :controller do
  describe 'POST #encode' do
    # before do
    #   post :encode
    #   post 'api/v1/encode', params: valid_params
    # end

    context 'when valid url' do
      let(:valid_params) { { original_url: 'https://www.coursera.org/learn/algorithms-divide-conquer?action=enroll&specialization=algorithms' } }

      it 'returns http success' do
        post :create, params: valid_params
        expect(response).to have_http_status(:success)
      end
    end
  end
end
