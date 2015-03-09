require 'specinfra/ec2_metadata/tags/version'
require 'aws-sdk'

module Specinfra
  class Ec2Metadata
    class Tags
      def self.get
        ec2 = Aws::EC2::Client.new
        page = ec2.describe_tags(
          :filters => [{
            :name   => 'resource-id',
            :values => [ host_inventory['ec2']['instance-id'] ],
          }]
        )
        tags = {}
        page.each do |p|
          page.tags.each do |t|
            tags[t['key']] = t['value']
          end
        end
        tags
      end
    end
  end
end
