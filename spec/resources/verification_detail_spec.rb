require 'spec_helper'

describe GoCardlessPro::Resources::VerificationDetail do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.verification_details.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'address_line1' => 'address_line1-input',
          'address_line2' => 'address_line2-input',
          'address_line3' => 'address_line3-input',
          'city' => 'city-input',
          'company_number' => 'company_number-input',
          'description' => 'description-input',
          'directors' => 'directors-input',
          'links' => 'links-input',
          'postal_code' => 'postal_code-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/verification_details}).
          with(
            body: {
              'verification_details' => {

                'address_line1' => 'address_line1-input',
                'address_line2' => 'address_line2-input',
                'address_line3' => 'address_line3-input',
                'city' => 'city-input',
                'company_number' => 'company_number-input',
                'description' => 'description-input',
                'directors' => 'directors-input',
                'links' => 'links-input',
                'postal_code' => 'postal_code-input',
              },
            }
          ).
          to_return(
            body: {
              'verification_details' =>

                {

                  'address_line1' => 'address_line1-input',
                  'address_line2' => 'address_line2-input',
                  'address_line3' => 'address_line3-input',
                  'city' => 'city-input',
                  'company_number' => 'company_number-input',
                  'description' => 'description-input',
                  'directors' => 'directors-input',
                  'links' => 'links-input',
                  'postal_code' => 'postal_code-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::VerificationDetail)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/verification_details}).to_return(
          body: {
            error: {
              type: 'validation_failed',
              code: 422,
              errors: [
                { message: 'test error message', field: 'test_field' },
              ],
            },
          }.to_json,
          headers: response_headers,
          status: 422
        )
      end

      it 'throws the correct error' do
        expect { post_create_response }.to raise_error(GoCardlessPro::ValidationError)
      end
    end

    context 'with a request that returns an idempotent creation conflict error' do
      let(:id) { 'ID123' }

      let(:new_resource) do
        {

          'address_line1' => 'address_line1-input',
          'address_line2' => 'address_line2-input',
          'address_line3' => 'address_line3-input',
          'city' => 'city-input',
          'company_number' => 'company_number-input',
          'description' => 'description-input',
          'directors' => 'directors-input',
          'links' => 'links-input',
          'postal_code' => 'postal_code-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/verification_details}).to_return(
          body: {
            error: {
              type: 'invalid_state',
              code: 409,
              errors: [
                {
                  message: 'A resource has already been created with this idempotency key',
                  reason: 'idempotent_creation_conflict',
                  links: {
                    conflicting_resource_id: id,
                  },
                },
              ],
            },
          }.to_json,
          headers: response_headers,
          status: 409
        )
      end

      it 'raises an InvalidStateError' do
        expect { post_create_response }.to raise_error(GoCardlessPro::InvalidStateError)
        expect(post_stub).to have_been_requested
      end
    end
  end
end
