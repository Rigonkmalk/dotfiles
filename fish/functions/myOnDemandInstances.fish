function myOnDemandInstances
	aws ec2 describe-instances \
		--filters "Name=tag:Env,Values=Rigonkmalk*" \
		--query 'Reservations[*].Instances | [].[InstanceId, Tags[?Key==`Name`].Value | [0], PrivateIpAddress, State.Name, LaunchTime]' \
		--output json | jq -r 'sort_by(.[1]) | .[] | @tsv' | sed 's/ /-/g' | column -t
end
