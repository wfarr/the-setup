require "net/http"
require "open3"
require "uri"

def whyrun_supported?
  true
end

action :set do
  if config_for_resource(new_resource).empty? || !api_access_ok?(new_resource)
    converge_by("Setting credentials in git credential helper for #{new_resource.host}") do
      puts
      puts "You need to get a application password from #{new_resource.protocol}://#{new_resource.host}/settings/applications#personal-access-tokens"
      print "What is your password?: "

      pass = $stdin.gets.chomp

      # we can end up with duplicate entries that create weird breakages
      # so delete all our credentials for this host first
      delete_credentials(new_resource)
      set_password_for_resource(new_resource, pass)
    end

    new_resource.updated_by_last_action(true)
  end
end

action :unset do
  if !config_for_resource(new_resource).empty?
    converge_by("Removing credentials in git credential helper for #{new_resource.host}") do
      delete_credentials(new_resource)
    end

    new_resource.updated_by_last_action(true)
  end
end

def api_access_ok?(new_resource)
  config = config_for_resource(new_resource)
  api_url = "#{new_resource.protocol}://"

  if new_resource.host == "github.com"
    api_url << "api.github.com"
  else
    api_url << "#{new_resource.host}/api/v3"
  end
  uri = URI.parse("#{api_url}/users/wfarr")
  params = { :access_token => config["username"] }
  uri.query = URI.encode_www_form(params)

  Chef::Log.debug "Checking auth token using #{api_url}/users/wfarr?access_token=#{config['username']}"
  res = Net::HTTP.get_response(uri)

  res.is_a?(Net::HTTPSuccess)
rescue SocketError => e
  Chef::Log.warn "Not connected to the Internet, skipping credential verification!"
  true
end

def delete_credentials(new_resource)
  Chef::Log.debug "Removing git credentials for #{new_resource.host}"

  git_credential_run("erase", {
    "host"     => new_resource.host,
    "protocol" => new_resource.protocol
  })
end

def set_password_for_resource(new_resource, pass)
  Chef::Log.debug "Set git credentials for #{new_resource.host}"

  git_credential_run("store", {
    "host"     => new_resource.host,
    "protocol" => new_resource.protocol,
    "username" => pass,
    "password" => "x-oauth-basic"
  })
end

def config_for_resource(new_resource)
  git_credential_run("get", {
    "host"     => new_resource.host,
    "protocol" => new_resource.protocol
  })
end

def git_credential_run(cmd, body)
  if body.kind_of? Hash
    body = body.map {|k, v| "#{k}=#{v}"}.join "\n"
  end

  result = ""

  status = Open3.popen3({"PATH" => "/usr/local/bin:/usr/bin:/bin"}, "git credential-osxkeychain #{cmd}") do |stdin, stdout, stderr, wait_thr|
    stdin.write body
    stdin.puts
    stdin.puts

    stdin.close

    result = stdout.read

    if wait_thr.value != 0
      raise "Working with the git credential helper failed #{stdin} #{stderr}"
    end
  end


  config = {}
  result.lines.each do |line|
    if line =~ /(.*)=(.*)/
      config[$1] = $2
    end
  end
  config
end
