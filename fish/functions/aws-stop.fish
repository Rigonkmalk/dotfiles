function aws-stop
	aws ec2 stop-instances --instance-ids $argv
end
