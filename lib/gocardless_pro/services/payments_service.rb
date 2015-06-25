require_relative './base_service'

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank

module GoCardlessPro
  module Services
    # Service for making requests to the Payment endpoints
    class PaymentsService < BaseService
      # <a name="mandate_is_inactive"></a>Creates a new payment object.
      #
      # This
      # fails with a `mandate_is_inactive` error if the linked
      # [mandate](https://developer.gocardless.com/pro/2015-04-29/#core-endpoints-mandates)
      # is cancelled. Payments can be created against `pending_submission` mandates,
      # but they will not be submitted until the mandate becomes active.
      # Example URL: /payments
      # @param options [Hash] parameters as a hash, under a params key.
      def create(options = {})
        path = '/payments'

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params
        response = make_request(:post, path, options)

        return if response.body.nil?
        Resources::Payment.new(unenvelope_body(response.body))
      end

      # Returns a
      # [cursor-paginated](https://developer.gocardless.com/pro/2015-04-29/#overview-cursor-pagination)
      # list of your payments.
      # Example URL: /payments
      # @param options [Hash] parameters as a hash, under a params key.
      def list(options = {})
        path = '/payments'

        response = make_request(:get, path, options)
        ListResponse.new(
          raw_response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Payment
        )
      end

      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options [Hash] parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          path: '/payments',
          options: options,
          resource_class: Resources::Payment
        ).enumerator
      end

      # Retrieves the details of a single existing payment.
      # Example URL: /payments/:identity
      #
      # @param identity       # Unique identifier, beginning with "PM"
      # @param options [Hash] parameters as a hash, under a params key.
      def get(identity, options = {})
        path = sub_url('/payments/:identity',           'identity' => identity)

        response = make_request(:get, path, options)

        return if response.body.nil?
        Resources::Payment.new(unenvelope_body(response.body))
      end

      # Updates a payment object. This accepts only the metadata parameter.
      # Example URL: /payments/:identity
      #
      # @param identity       # Unique identifier, beginning with "PM"
      # @param options [Hash] parameters as a hash, under a params key.
      def update(identity, options = {})
        path = sub_url('/payments/:identity',           'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params][envelope_key] = params
        response = make_request(:put, path, options)

        return if response.body.nil?
        Resources::Payment.new(unenvelope_body(response.body))
      end

      # Cancels the payment if it has not already been submitted to the banks. Any
      # metadata supplied to this endpoint will be stored on the payment cancellation
      # event it causes.
      #
      # This will fail with a `cancellation_failed` error unless
      # the payment's status is `pending_submission`.
      # Example URL: /payments/:identity/actions/cancel
      #
      # @param identity       # Unique identifier, beginning with "PM"
      # @param options [Hash] parameters as a hash, under a params key.
      def cancel(identity, options = {})
        path = sub_url('/payments/:identity/actions/cancel',           'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params
        response = make_request(:post, path, options)

        return if response.body.nil?
        Resources::Payment.new(unenvelope_body(response.body))
      end

      # <a name="retry_failed"></a>Retries a failed payment if the underlying mandate
      # is active. You will receive a `resubmission_requested` webhook, but after that
      # retrying the payment follows the same process as its initial creation, so you
      # will receive a `submitted` webhook, followed by a `confirmed` or `failed`
      # event. Any metadata supplied to this endpoint will be stored against the
      # payment submission event it causes.
      #
      # This will return a `retry_failed`
      # error if the payment has not failed.
      #
      # Payments can be retried up to 3
      # times.
      # Example URL: /payments/:identity/actions/retry
      #
      # @param identity       # Unique identifier, beginning with "PM"
      # @param options [Hash] parameters as a hash, under a params key.
      def retry(identity, options = {})
        path = sub_url('/payments/:identity/actions/retry',           'identity' => identity)

        params = options.delete(:params) || {}
        options[:params] = {}
        options[:params]['data'] = params
        response = make_request(:post, path, options)

        return if response.body.nil?
        Resources::Payment.new(unenvelope_body(response.body))
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
        'payments'
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
