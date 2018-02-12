# encoding: utf-8
# author: 2017, Christoph Hartmann

title 'ec2-test-profile'

control "ami" do
  title "Verifies that the correct AMI image is used"
  describe ec2_instance do
    its("ami_id") { should cmp "ami-1b2bb774" }
  end
end

control "tags" do
  title "Verifies that the X-Owner tag is set"
  describe ec2_instance.tags do
    its("X-Owner") { should cmp "dev-sec" }
  end
end
