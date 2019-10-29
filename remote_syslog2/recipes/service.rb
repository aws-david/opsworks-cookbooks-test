template '/etc/init.d/remote_syslog2' do
  source 'remote_syslog2.erb'
  mode '0755'
  notifies :restart, 'service[remote_syslog2]', :delayed
end

if platform?("ubuntu") && node[:platform_version] == "18.04"
  execute 'systemctl daemon-reload' do
    command 'systemctl daemon-reload'
    action :nothing
  end
end

service 'remote_syslog2' do
  supports restart: true, status: true
  action [:start, :enable]
  retries 3
  if platform?("ubuntu") && node[:platform_version] == "18.04"
    provider Chef::Provider::Service::Systemd
  end
end


