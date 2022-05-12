# frozen_string_literal: true

Rails.application.routes.draw do
  get '/:shortened_slug', to: 'urls#redirect'

  namespace :api do
    namespace :v1 do
      post '/encode', to: 'urls#create'
      post '/decode', to: 'urls#decode'
    end
  end
end
