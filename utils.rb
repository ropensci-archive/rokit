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
