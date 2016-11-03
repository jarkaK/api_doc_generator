# Api Doc Generator

- early stage of development, not ready yet

Generation of API documentation using the Blueprint format specs that supports Rack::Test specs.

The Blueprint documentation is generated according to its specifications and can be directly used with Aglio.

## Installation

Add this line to your application's Gemfile:

    gem 'api_doc_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install api_doc_generator

## Usage

In your spec_helper.rb file add

    require 'api_doc_generator'

Write tests using the following convention:

- Tests must be tagged with `type: :request`
- Group/Collection/Action/Action titles are taken from the`describe` and `context` part of the specs
- you can specify parameters by using param method
  - this methods allows following options in the option has
    - name
    - type
    - description
    - required 
    - example

Example:
    
    require 'spec_helper'
    
    describe 'Resource Group', type: :request do
      let(:token_param) do
        { api_key: user.authentication_token }
      end
    
      context 'Events Collection' do
        context 'GET /' do
          context 'List of all events' do
            param :api_token, { type: :string, description: 'User api token', example: 'Hmgfh89', required: true }
            param :sort, { type: :string, description: 'How to sort the colleciton', example: '-title' }
    
            before do
              get '/events', token_param
            end
    
            it 'should return correct status' do
              expect(last_response.status).to eq(200)
            end
          end
        end
      end
    end

    

The output:

    # Resource Group
    
    # Events Collection [/events]
    
    ##  events [GET]
    
    + Parameters 
        + api_token: `Hmgfh89` (string, required) - User api token
        + sort: `-title` (string, optional) - How to sort the colleciton
    
    + Response 200 (application/json)
    
            {
              "data": [
                {
                    "id": 2,
                    "title": "End of world event",
                    "description": null,
                    "date": "2016-05-15 00:00",
                    "place": null,
                    "user_id": 2,
                    "created_at": "2016-11-01T22:19:59.212Z",
                    "updated_at": "2016-11-01T22:19:59.212Z"
                },
                {
                    "id": 1,
                    "title": "Wedding event",
                    "description": null,
                    "date": "2016-02-15 00:00",
                    "place": null,
                    "user_id": 1,
                    "created_at": "2016-11-01T22:19:59.208Z",
                    "updated_at": "2016-11-01T22:19:59.208Z"
                }
              ]
            }
            


    

## TODOs

This is a fresh project and there are a lot of possibilities how to improve it. Few suggestions:

- support Rails applications
- support all options of api_blueprint (important especially request)
- recheck with api_blueprint specification
- add other documentation formats as Swagger
- it needs more practice testing (and add some specs)
