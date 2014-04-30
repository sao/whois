namespace :whois do
  desc "get whois data and send email if not registerable"
  task :check_records, :domain_name do |t, args|
    d = Whois.whois(args[:domain_name])
    if d.match('pendingDelete').nil?
      send_email ENV['contact_email'], args[:domain_name]
      register_domain args[:domain_name]
    end
  end
end
