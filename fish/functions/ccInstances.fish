function ccInstances
	if test -z "$argv[1]"
		aws ec2 describe-instances \
			--filters "Name=tag:User,Values=CustomerCare" \
			--query "Reservations[*].Instances | [].[InstanceId, Tags[?Key=='Name'].Value | [0], PrivateIpAddress, State.Name, LaunchTime]" \
			--output json | jq -r 'sort_by(.[1]) | .[] | @tsv' | sed 's/ /-/g' | column -t
	else
		echo "Instances filtered on $argv[1]"
		aws ec2 describe-instances \
			--filters "Name=tag:User,Values=CustomerCare" \
			--query "Reservations[*].Instances | [].[InstanceId, Tags[?Key=='Name'].Value | [0], PrivateIpAddress, State.Name, LaunchTime]" \
			--output json | jq -r 'sort_by(.[1]) | .[] | @tsv' | sed 's/ /-/g' | column -t | grep "$argv[1]"
	end
end
