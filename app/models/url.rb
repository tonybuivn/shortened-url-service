# frozen_string_literal: true

# require 'rubygems'
require 'sanitize-url'

class Url < ApplicationRecord
  include SanitizeUrl

  validates :original_url, presence: true, length: { minimum: 25 }
  validates :sanitized_url, presence: true
  validates :shortened_slug, presence: true, uniqueness: true

  # TODO: Calculate number of short_slug
  # TODO: Handle duplicated shortened_slug
  def generate_short_slug
    new_shortened_slug = ''
    loop do
      new_shortened_slug = ([*('a'..'z'), *('A'..'Z'), *('0'..'9')]).sample(8).join

      break unless Url.find_by(shortened_slug: new_shortened_slug)
    end
    self.shortened_slug = new_shortened_slug
  end

  def generate_sanitized_url
    self.sanitized_url = sanitize_url(original_url, replace_evil_with: 'about:blank')
  end
end
