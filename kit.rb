require 'octokit'
require_relative 'array_methods'

@client = Octokit::Client.new(:access_token => ENV["GITHUB_TOKEN_ROAPI"])

repos = (1..4).map { |x| client.repos('ropenscilabs', :page => x) }.flatten
names = repos.map(&:name)
out = names.collect { |x| client.hooks('ropenscilabs/' + x) }

out2 = out.collect { |z|
	codecov = z.check_for_hook('codecov')
	travis = z.check_for_hook('travis')
	slack = z.check_for_hook('slack')

	{
		'codecov' => codecov,
		'travis' => travis,
		'slack' => slack
	}
};

dat = []
for i in 0..(names.length - 1) do
	dat << out2[i].merge('pkg' => names[i])
end

# those repos without slack hooks
dat.without_slack
dat.without_slack.map { |z| z['pkg'] }

# those repos without travis hooks
dat.without_travis

# those repos without codecov hooks
dat.without_codecov

# create hooks
pkgs = dat.without_slack.map { |z| z['pkg'] }
pkgs = pkgs.select { |x| x.match(/tutorial|test/).nil? }
hooks = pkgs[9..pkgs.length].map { |z| create_hook_slack('ropenscilabs/' + z) }
create_hook_slack('ropenscilabs/' + pkgs[2])
