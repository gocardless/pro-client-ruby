

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
    # Customer objects hold the contact details for a customer. A customer can
    # have several [customer bank
    # accounts](https://developer.gocardless.com/pro/2015-04-29/#core-endpoints-customer-bank-accounts),
    # which in turn can have several Direct Debit
    # [mandates](https://developer.gocardless.com/pro/2015-04-29/#core-endpoints-mandates).
    # Represents an instance of a customer resource returned from the API
    class Customer
      attr_reader :address_line1

      attr_reader :address_line2

      attr_reader :address_line3

      attr_reader :city

      attr_reader :company_name

      attr_reader :country_code

      attr_reader :created_at

      attr_reader :email

      attr_reader :family_name

      attr_reader :given_name

      attr_reader :id

      attr_reader :metadata

      attr_reader :postal_code

      attr_reader :region
      # initialize a resource instance
      # @param object [Hash] an object returned from the API
      def initialize(object)
        @object = object

        @address_line1 = object['address_line1']
        @address_line2 = object['address_line2']
        @address_line3 = object['address_line3']
        @city = object['city']
        @company_name = object['company_name']
        @country_code = object['country_code']
        @created_at = object['created_at']
        @email = object['email']
        @family_name = object['family_name']
        @given_name = object['given_name']
        @id = object['id']
        @metadata = object['metadata']
        @postal_code = object['postal_code']
        @region = object['region']
      end

      # Provides the resource as a hash of all it's readable attributes
      def to_h
        @object
      end
    end
  end
end
