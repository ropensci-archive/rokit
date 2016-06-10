def create_hook_slack(owner_repo)
	begin
		hk = @client.create_hook(
		  owner_repo,
		  'web',
		  {
		    :url => 'https://hooks.slack.com/services/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',
		    :content_type => 'json'
		  },
		  {
		    :events => ["commit_comment", "create", "delete", "deployment_status",
		        "fork", "issues", "issue_comment", "pull_request",
		        "pull_request_review_comment", "push", "release"],
		    :active => true
		  }
		)
	rescue Exception => e
		raise e
	end
	puts 'slack hook created for ' + owner_repo
	return hk
end

# out2 = out.collect { |z|
# 	codecov = z.check_for_hook('codecov')
# 	travis = z.check_for_hook('travis')
# 	slack = z.check_for_hook('slack')

# 	{
# 		'codecov' => codecov,
# 		'travis' => travis,
# 		'slack' => slack
# 	}
# };

# dat = []
# for i in 0..(names.length - 1) do
# 	dat << out2[i].merge('pkg' => names[i])
# end
