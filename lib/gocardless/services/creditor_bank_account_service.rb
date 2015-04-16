require_relative './base_service'

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank

module GoCardless
  module Services
    # Service for making requests to the CreditorBankAccount endpoints
    class CreditorBankAccountService < BaseService
      # Creates a new creditor bank account object.
      #
      # Bank account details may be
      # supplied using the IBAN (international bank account number) or [local
      # details](#ui-compliance-local-bank-details).
      # Example URL: /creditor_bank_accounts
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def create(options = {}, custom_headers = {})
        path = '/creditor_bank_accounts'
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::CreditorBankAccount.new(unenvelope_body(response.body))
      end

      # Returns a
      # [cursor-paginated](https://developer.gocardless.com/pro/#overview-cursor-pagination)
      # list of your creditor bank accounts.
      # Example URL: /creditor_bank_accounts
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def list(options = {}, custom_headers = {})
        path = '/creditor_bank_accounts'

        response = make_request(:get, path, options, custom_headers)
        ListResponse.new(
          raw_response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::CreditorBankAccount
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          path: '/creditor_bank_accounts',
          options: options
        ).enumerator
      end

      # Retrieves the details of an existing creditor bank account.
      # Example URL: /creditor_bank_accounts/:identity
      #
      # @param identity       # Unique identifier, beginning with "BA"
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def get(identity, options = {}, custom_headers = {})
        path = sub_url('/creditor_bank_accounts/:identity',           'identity' => identity)

        response = make_request(:get, path, options, custom_headers)

        Resources::CreditorBankAccount.new(unenvelope_body(response.body))
      end

      # Immediately disables the bank account, no money can be paid out to a disabled
      # account.
      #
      # This will return a `disable_failed` error if the bank account
      # has already been disabled.
      #
      # A disabled bank account can be re-enabled by
      # creating a new bank account resource with the same details.
      # Example URL: /creditor_bank_accounts/:identity/actions/disable
      #
      # @param identity       # Unique identifier, beginning with "BA"
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def disable(identity, options = {}, custom_headers = {})
        path = sub_url('/creditor_bank_accounts/:identity/actions/disable',           'identity' => identity)

        new_options = {}
        new_options['data'] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)

        Resources::CreditorBankAccount.new(unenvelope_body(response.body))
      end

      # Unenvelope the response of the body using the service's `envelope_key`
      #
      # @param body [Hash]
      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      private

      # return the key which API responses will envelope data under
      def envelope_key
        'creditor_bank_accounts'
      end

      # take a URL with placeholder params and substitute them out for the acutal value
      # @param url [String] the URL with placeholders in
      # @param param_map [Hash] a hash of placeholders and their actual values
      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", value)
        end
      end
    end
  end
end
