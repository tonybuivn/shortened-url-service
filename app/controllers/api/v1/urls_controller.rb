# frozen_string_literal: true

class Api::V1::UrlsController < ApplicationController
  BASE_URL = 'http://localhost:3000/'

  def create
    url = Url.new(url_params)
    url.generate_short_slug
    url.generate_sanitized_url
    if url.save
      render json: { shortened_url: BASE_URL + url.shortened_slug, sanitized_url: url.sanitized_url }
    else
      render json: { error: 'Cannot shorten URL' }
    end
  end

  def decode
    shortened_slug = decode_url_params[:shortened_url].gsub(BASE_URL, '')
    url = Url.find_by(shortened_slug: shortened_slug)
    if url
      render json: { original_url: url.original_url }
    else
      render json: { error: 'Cannot find original URL' }
    end
  end

  private

  def url_params
    params.permit(:original_url)
  end

  def decode_url_params
    params.permit(:shortened_url)
  end
end
