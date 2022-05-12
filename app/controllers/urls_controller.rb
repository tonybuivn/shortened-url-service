# frozen_string_literal: true

class UrlsController < ApplicationController
  def redirect
    url = Url.find_by(shortened_slug: params[:shortened_slug])

    # url.update_attribute(:clicked, url.clicked + 1)
    if url
      redirect_to url.original_url
    else
      render json: { error: 'bad link' }, status: :unprocessable_entity
    end
  end
end
