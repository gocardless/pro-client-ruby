require 'spec_helper'

describe GoCardlessPro::Resources::BillingRequestFlow do
  let(:client) do
    GoCardlessPro::Client.new(
      access_token: 'SECRET_TOKEN'
    )
  end

  let(:response_headers) { { 'Content-Type' => 'application/json' } }

  describe '#create' do
    subject(:post_create_response) { client.billing_request_flows.create(params: new_resource) }
    context 'with a valid request' do
      let(:new_resource) do
        {

          'authorisation_url' => 'authorisation_url-input',
          'created_at' => 'created_at-input',
          'expires_at' => 'expires_at-input',
          'links' => 'links-input',
          'redirect_uri' => 'redirect_uri-input',
        }
      end

      before do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).
          with(
            body: {
              'billing_request_flows' => {

                'authorisation_url' => 'authorisation_url-input',
                'created_at' => 'created_at-input',
                'expires_at' => 'expires_at-input',
                'links' => 'links-input',
                'redirect_uri' => 'redirect_uri-input',
              },
            }
          ).
          to_return(
            body: {
              'billing_request_flows' =>

                {

                  'authorisation_url' => 'authorisation_url-input',
                  'created_at' => 'created_at-input',
                  'expires_at' => 'expires_at-input',
                  'links' => 'links-input',
                  'redirect_uri' => 'redirect_uri-input',
                },

            }.to_json,
            headers: response_headers
          )
      end

      it 'creates and returns the resource' do
        expect(post_create_response).to be_a(GoCardlessPro::Resources::BillingRequestFlow)
      end
    end

    context 'with a request that returns a validation error' do
      let(:new_resource) { {} }

      before do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).to_return(
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

          'authorisation_url' => 'authorisation_url-input',
          'created_at' => 'created_at-input',
          'expires_at' => 'expires_at-input',
          'links' => 'links-input',
          'redirect_uri' => 'redirect_uri-input',
        }
      end

      let!(:post_stub) do
        stub_request(:post, %r{.*api.gocardless.com/billing_request_flows}).to_return(
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
