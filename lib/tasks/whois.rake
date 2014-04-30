namespace :whois do
  desc "get whois data and send email if not registerable"
  task :check_records, :domain_name do |t, args|
    d = Whois.whois(args[:domain_name])
    if d.match('pendingDelete').nil?
      send_email ENV['contact_email'], args[:domain_name]
    end
  end
end

def send_email email, domain
  RestClient.post "https://api:#{ENV['mailgun_api_key']}"\
    "@api.mailgun.net/v2/sandbox1cd1bda3ce10419b949ba4746e3546d2.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox1cd1bda3ce10419b949ba4746e3546d2.mailgun.org>",
    :to => email,
    :subject => "#{domain} has moved out of pendingDelete status",
    :text => "you know what this is you bitch"
end
