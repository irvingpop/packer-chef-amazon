# -*- mode: ruby -*-
# vi: set ft=ruby :
# Vagrantfile example using these boxes
require 'yaml'

Vagrant.configure("2") do |config|
	config.vm.box = "centos-6_5-64_percona"
	#config.vm.box = "perconajayj/centos-x86_64"
	config.ssh.username = "root"

	config.vm.provider :aws do |aws, override|
		aws.region = "us-east-1"
		aws_config = YAML::load_file(File.join(Dir.home, ".aws_secrets"))
		aws.access_key_id = aws_config.fetch("access_key_id")
		aws.secret_access_key = aws_config.fetch("secret_access_key")
		aws.keypair_name = aws_config.fetch("keypair_name")
		name = aws_config.fetch("instance_name_prefix") + " Vagrant Percona Server"
		aws.tags = {
			'Name' => name
		}
		override.ssh.private_key_path = aws_config.fetch("keypair_path")

		# Block device mapping will work when vagrant-aws 0.3 is released.
		# Until then, this config will not work and must be done at the box level in Packer
		aws.block_device_mapping = [
			{
		        'DeviceName' => "/dev/sdl",
		        'VirtualName' => "mysql_data",
		        'Ebs.VolumeSize' => 20,
		        'Ebs.DeleteOnTermination' => true
			}
		]
	end

	# Add provisioner info here

end
