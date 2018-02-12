# Ec2 Instance InSpec Example Profile

This example shows the implementation of an InSpec profile that verifies:

- the instance uses the correct AMI
- some tags are set properly for the machine

## Requirements

- curl cli
- aws cli
- permission to read the tags

In order to be able to read the permissions, you need to configure the right IAM policy for each instance:
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:DescribeTags",
            "Resource": "*"
        }
    ]
}
```

### Platform

- Amazon Linux

## Usage

InSpec makes it easy to run your tests wherever you need. More options listed here: [InSpec cli](http://inspec.io/docs/reference/cli/)

```
# run profile locally
$ git clone https://github.com/chris-rock/ec2-example-profile.git
$ inspec exec ec2-example-profile

# run profile locally and directly from Github
$ inspec exec https://github.com/chris-rock/ec2-example-profile

# run profile on remote host via SSH
inspec exec ec2-example-profile -t ssh://user@hostname -i /path/to/key
```

## Roadmap

The plan is to make the `ec2_instance` resource available into core InSpec.

## Kudos

The profile is heavily inspired by the work from [Alex Pop's ec2_instance profile](https://github.com/alexpop/ec2-instance-profile)

## License and Author

* Author:: Christoph Hartmann <chris@lollyrock.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.