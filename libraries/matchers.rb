if defined?(ChefSpec)
  def run_twemproxy_install(name)
    ChefSpec::Matchers::ResourceMatcher.new(:twemproxy_install, :run, name)
  end

  def run_twemproxy_configure(name)
    ChefSpec::Matchers::ResourceMatcher.new(:twemproxy_configure, :run, name)
  end

  def run_twemproxy_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:twemproxy_service, :run, name)
  end

  def enable_twemproxy_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:twemproxy_service, :enable, name)
  end

  def start_twemproxy_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:twemproxy_service, :start, name)
  end

  def restart_twemproxy_service(name)
    ChefSpec::Matchers::ResourceMatcher.new(:twemproxy_service, :restart, name)
  end
end