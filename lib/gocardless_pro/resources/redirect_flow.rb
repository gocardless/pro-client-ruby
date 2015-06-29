

# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank
#
require 'uri'

module GoCardlessPro
  # A module containing classes for each of the resources in the GC Api
  module Resources
    # Redirect flows enable you to use GoCardless Pro's [hosted payment
    # pages](https://pay-sandbox.gocardless.com/AL000000AKFPFF) to set up mandates
    # with your customers. These pages are fully compliant and have been
    # translated into Dutch, French, German, Italian, Portuguese and Spanish.
    #
    #
    # The overall flow is:
    #
    # 1. You [create](#create-a-redirect-flow)
    # a redirect flow for your customer, and redirect them to the returned
    # redirect url, e.g. `https://pay.gocardless.com/flow/RE123`.
    #
    # 2. Your
    # customer supplies their name, email, address, and bank account details, and
    # submits the form. This securely stores their details, and redirects them
    # back to your `success_redirect_url` with `redirect_flow_id=RE123` in the
    # querystring.
    #
    # 3. You [complete](#complete-a-redirect-flow) the
    # redirect flow, which creates a [customer](#core-endpoints-customers),
    # [customer bank account](#core-endpoints-customer-bank-accounts), and
    # [mandate](#core-endpoints-mandates), and returns the ID of the mandate. You
    # may wish to create a [subscription](#core-endpoints-subscriptions) or
    # [payment](#core-endpoints-payments) at this point.
    #
    # It is
    # recommended that you link the redirect flow to your user object as soon as
    # it is created, and attach the created resources to that user in the complete
    # step.
    #
    # Redirect flows expire 30 minutes after they are first
    # created. You cannot complete an expired redirect flow.
    # Represents an instance of a redirect_flow resource returned from the API
    class RedirectFlow
      attr_reader :created_at

      attr_reader :description

      attr_reader :id

      attr_reader :redirect_url

      attr_reader :scheme

      attr_reader :session_token

      attr_reader :success_redirect_url
      # initialize a resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object, response = nil)
        @object = object

        @created_at = object['created_at']
        @description = object['description']
        @id = object['id']
        @links = object['links']
        @redirect_url = object['redirect_url']
        @scheme = object['scheme']
        @session_token = object['session_token']
        @success_redirect_url = object['success_redirect_url']
        @response = response
      end

      def api_response
        ApiResponse.new(@response.api_response)
      end

      # return the links that the resource has
      def links
        Struct.new(
          *{

            creditor: '',

            mandate: ''

          }.keys.sort
        ).new(*@links.sort.map(&:last))
      end

      # Provides the resource as a hash of all it's readable attributes
      def to_h
        @object
      end
    end
  end
end
