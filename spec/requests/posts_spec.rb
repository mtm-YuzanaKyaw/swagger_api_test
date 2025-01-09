require 'swagger_helper'

RSpec.describe 'posts', type: :request do

  path '/posts' do

    get('list posts') do
      response(200, 'successful') do

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create post') do
      tags 'Resource'
      consumes 'application/json'
      parameter name: 'create_post', in: :body, required: true, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :text }
        },
        required: %w[ title content ]
      }
      response(200, 'successful') do
        let(:update_post) {{ title: "Testing Title", content: "This is Testing content" }}
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/posts/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show post') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    patch('update post') do
      tags 'Resource'
      consumes 'application/json'
      parameter name: 'update_post', in: :body, required: true, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          content: { type: :text }
        },
        required: %w[ title content ]
      }
      response(200, 'successful') do
        let(:id) { '123' }
        let(:update_post) {{ title: "Update Testing Title", content: "This is Testing content" }}

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update post') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete post') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
