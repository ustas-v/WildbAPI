# frozen_string_literal: true

module Integrations
  class Base < ActiveInteraction::Base
    include HTTParty

    API_VERSION = :v1

    RESOURCES = {
      # Resources in APIs
      # for example:
      # orders: 'Orders'
    }.freeze

    # Ignore verify SSL options
    default_options.update verify: false

    debug_output $stdout
    base_uri     nil # Base API url

    string :access_token, default: nil
    string :param_token,  default: nil

    def execute
      self
    end

    def api_version
      self.class::API_VERSION
    end

    def api_prefix
      nil
    end

    def self.resources
      self::RESOURCES
    end

    def resources
      @resources ||= {}
    end

    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||=
          begin
            resource = "Resources::#{api_version.to_s.upcase}::#{self.class.resources[name]}"
            klass = "#{self.class.to_s.split('::')[0...-1].join('::')}::#{resource}".constantize
            klass.run! client: self
          end
        resources[name]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      self.class.resources.keys.include?(method_name) || super
    end

    # Actions

    def post(resource, body)
      self.class.post(resource_type(resource), body: body, headers: headers)
    end

    def put(resource, body)
      self.class.put(resource_type(resource), body: body, headers: headers)
    end

    def get(resource, params = {})
      self.class.get(resource_type(resource), { headers: headers, **http_params(params) })
    end

    def delete(resource)
      self.class.delete(resource_type(resource), { headers: headers })
    end

    private

    def resource_type(resource)
      "#{resource}.json"
    end

    def headers
      {}.merge(bearer_headers)
    end

    def bearer_headers
      access_token? ? { 'Authorization' => "Bearer #{access_token}" } : {}
    end

    def http_params(params)
      params[:query][param_token_name] = param_token if param_token?
      params
    end
  end
end
