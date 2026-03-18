function stopMyOnDemandInstances
	set -l instances

	if test -z "$argv[1]"
		set instances (myOnDemandInstances | awk '{print $1}' | string collect)
	else
		set instances (myOnDemandInstances | grep "Rigonkmalk-$argv[1]" | awk '{print $1}' | string collect)
		echo "Stopping workspace $argv[1]..."
	end

	if test -n "$instances"
		echo $instances | xargs aws ec2 stop-instances --instance-ids
	end
end
