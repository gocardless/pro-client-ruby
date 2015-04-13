require_relative './base_service'



# encoding: utf-8
#
# WARNING: Do not edit by hand, this file was generated by Crank:
#
#   https://github.com/gocardless/crank

module GoCardless
  module Services
    class RoleService < BaseService
    
      
      # Create a role with set access permissions
      # Example URL: /roles
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def create(options = {}, custom_headers = {})
        path = "/roles"
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)
        
        Resources::Role.new(unenvelope_body(response.body))
      end
      
      
      # List all existing roles
      # Example URL: /roles
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def list(options = {}, custom_headers = {})
        path = "/roles"
        
        response = make_request(:get, path, options, custom_headers)
        ListResponse.new(
          raw_response: response,
          unenveloped_body: unenvelope_body(response.body),
          resource_class: Resources::Role
        )
      end
      
      # Get a lazily enumerated list of all the items returned. This is simmilar to the `list` method but will paginate for you automatically.
      #
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Otherwise they will be the body of the request.
      def all(options = {})
        Paginator.new(
          service: self,
          path: "/roles",
          options: options
        ).enumerator
      end
      
      # Retrieve all details for a single role
      # Example URL: /roles/:identity
      #
      # @param identity:       # Unique identifier, beginning with "RO" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def get(identity, options = {}, custom_headers = {})
        path = sub_url("/roles/:identity", { 
          'identity' => identity
        })
        
        
        response = make_request(:get, path, options, custom_headers)
        
        Resources::Role.new(unenvelope_body(response.body))
      end
      
      
      # Updates a role object. Supports all of the fields supported when creating a
# role.
      # Example URL: /roles/:identity
      #
      # @param identity:       # Unique identifier, beginning with "RO" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def update(identity, options = {}, custom_headers = {})
        path = sub_url("/roles/:identity", { 
          'identity' => identity
        })
        
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:put, path, options, custom_headers)
        
        Resources::Role.new(unenvelope_body(response.body))
      end
      
      
      # Disables a role
      # Example URL: /roles/:identity/actions/disable
      #
      # @param identity:       # Unique identifier, beginning with "RO" }}
      # @param options: parameters as a hash. If the request is a GET, these will be converted to query parameters.
      # Else, they will be the body of the request.
      def disable(identity, options = {}, custom_headers = {})
        path = sub_url("/roles/:identity/actions/disable", { 
          'identity' => identity
        })
        
        new_options = {}
        new_options[envelope_key] = options
        options = new_options
        response = make_request(:post, path, options, custom_headers)
        
        Resources::Role.new(unenvelope_body(response.body))
      end
      

      def unenvelope_body(body)
        body[envelope_key] || body['data']
      end

      private

      def envelope_key
        "roles"
      end

      def sub_url(url, param_map)
        param_map.reduce(url) do |new_url, (param, value)|
          new_url.gsub(":#{param}", value)
        end
      end
    end
  end
end

