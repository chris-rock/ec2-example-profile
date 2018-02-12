# encoding: utf-8
# author: 2017, Christoph Hartmann

title 'ec2-test-profile'

describe ec2_instance do
  its("ami_id") { should cmp "ami-1b2bb774" }
end

describe ec2_instance.tags do
  its("X-Owner") { should cmp "chartmann" }
  its("X-Department") { should cmp "chef" }
end
