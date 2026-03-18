function userOnDemandInstances
	set -l onDemandUser ""

	switch $argv[1]
		case pazema
			set onDemandUser Rigonkmalk
		case smartinez
			set onDemandUser smartin-ez
		case lrhazaoui
			set onDemandUser finskou-centreon
	end

	if test -z "$onDemandUser"
		set onDemandUser $argv[1]
	else
		echo "$argv[1] declared as $onDemandUser"
	end

	aws ec2 describe-instances \
		--filters "Name=tag:Env,Values=$onDemandUser*" \
		--query 'Reservations[*].Instances | [].[InstanceId, Tags[?Key==`Name`].Value | [0], PrivateIpAddress, State.Name, LaunchTime]' \
		--output json | jq -r 'sort_by(.[1]) | .[] | @tsv' | sed 's/ /-/g' | column -t
end
