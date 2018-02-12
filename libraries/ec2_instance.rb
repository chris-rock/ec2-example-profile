class Ec2Instance < Inspec.resource(1)
    name 'ec2_instance'
  
    desc "
        The `ec2_instance` resource provides the ability to test meta-data and user-data for compute instances in AWS.
    "

    def initialize(opts = {})
      if !inspec.command("curl").exist?
        return skip_resource "'curl' is required on the instance for the resource to work."
      end

    end

    def instance_id
        cmd = "curl --silent --show-error --retry 3 http://169.254.169.254/latest/meta-data/instance-id"
        inspec.command(cmd).stdout
    end
    

    def ami_id
        cmd = "curl --silent --show-error --retry 3 http://169.254.169.254/latest/meta-data/ami-id"
        inspec.command(cmd).stdout
    end

    def region
        cmd = "curl --silent --show-error --retry 3 http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//'"
        inspec.command(cmd).stdout
    end

    def tags
        # this requires the instance to have the aws instance installed
        cmd = "aws ec2 describe-tags --region eu-central-1 --filters \"Name=resource-id,Values=#{instance_id}\""
        return parse_tags(inspec.command(cmd).stdout)
    end

    def to_s
        "ec2_instance"
    end

    private

    # {
    #     "Tags": [
    #         {
    #             "ResourceType": "instance", 
    #             "ResourceId": "i-09c38aee05afc7061", 
    #             "Value": "chartmann", 
    #             "Key": "X-Contact"
    #         }
    #     ]
    # }
    def parse_tags(content)
        return @tags if defined?(@tags)
        require 'json'
        j = JSON.parse(content)
        data = j["Tags"].reduce({}) { |res, x| 
            res[x["Key"]] = x["Value"]
            res
        }
        data
        @tags = Hashie::Mash.new(data)
    rescue JSON::ParserError => _e
      return Hashie::Mash.new({})
    end

end