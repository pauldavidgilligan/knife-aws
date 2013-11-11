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
          
        end
      end
  end
end
