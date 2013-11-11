require 'chef/knife'

class Chef
  class Knife
    module AwsBase

      def self.included(includer)
        includer.class_eval do

          deps do
            require 'fog'
            require 'readline'
            require 'chef/json_compat'
          end

          option :aws_credential_file,
            :long => "--aws-credential-file FILE",
            :description => "File containing AWS credentials as used by aws cmdline tools",
            :proc => Proc.new { |key| Chef::Config[:knife][:aws_credential_file] = key }

          option :aws_access_key_id,
            :short => "-A ID",
            :long => "--aws-access-key-id KEY",
            :description => "Your AWS Access Key ID",
            :proc => Proc.new { |key| Chef::Config[:knife][:aws_access_key_id] = key }

          option :aws_secret_access_key,
            :short => "-K SECRET",
            :long => "--aws-secret-access-key SECRET",
            :description => "Your AWS API Secret Access Key",
            :proc => Proc.new { |key| Chef::Config[:knife][:aws_secret_access_key] = key }

          option :region,
            :long => "--region REGION",
            :description => "Your AWS region",
            :proc => Proc.new { |key| Chef::Config[:knife][:region] = key }

          option :confluence_config_url,
            :short => '-C URL',
            :long => '--confluence-config-url URL',
            :description => "Specify confluence rest api url",
            :proc => Proc.new { |url| Chef::Config[:knife][:confluence_config_url] = url }

        end
      end

      def exit_with_message(message)
        ui.fatal message
        Kernel.exit(1)
      end

      def connection
        @connection ||= begin
          connection = Fog::Compute.new(
            :provider => 'AWS',
            :aws_access_key_id => Chef::Config[:knife][:aws_access_key_id],
            :aws_secret_access_key => Chef::Config[:knife][:aws_secret_access_key],
            :region => locate_config_value(:region)
          )
        end
      end

      def locate_config_value(key)
        key = key.to_sym
        config[key] || Chef::Config[:knife][key]
      end

      def validate!
        if Chef::Config[:knife][:confluence_config_url].nil?
          exit_with_message("Confluence wiki URL parameter is required.")
        end
      end

    end
  end

  class AwsSecurityList < Chef::Knife
    include Knife::AwsBase
    banner "knife aws security list"

    def run
      validate!
    end
  end


end
