class Array
	def check_for_hook(name)
		return self.collect { |w|
			w.to_h.values.flatten.map {|x| !x.to_s.match(/#{name}/i).nil?}.any?
		}.any?
	end
end

class Array
	def without_travis
		return self.select { |w| !w['travis'] }
	end
end

class Array
	def without_codecov
		return self.select { |w| !w['codecov'] }
	end
end

class Array
	def without_slack
		return self.select { |w| !w['slack'] }
	end
end
