require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/reloader'
require 'sinatra/cross_origin'
require 'json'
require 'pry'
require_relative '../../lib/hand'
require_relative '../../lib/validator'

class API < Sinatra::Base
  include Validator

  configure do
    register Sinatra::Namespace
    register Sinatra::CrossOrigin
  end

  configure :development do
    register Sinatra::Reloader
  end

  enable :cross_origin

  namespace '/api' do
    namespace '/v1' do
      get '/cards' do
        content_type :json
        query = params.keys.reduce
        if valid?(query)
          @hand = Hand.new(query)
          { cards: formatted_cards, value: @hand.evaluate }.to_json
        else
          "Invalid Query".to_json
        end
      end
    end
  end

  private

  def formatted_cards
    @hand.faces.map.with_index { |face,index| "#{face} of #{@hand.suits[index]}" }
  end

end