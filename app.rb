require 'sinatra'
require 'rest_client'
require 'whois'
require 'dnsimple'
require 'dotenv'

Dotenv.load

def send_email email, domain
  RestClient.post "https://api:#{ENV['mailgun_api_key']}"\
    "@api.mailgun.net/v2/sandbox1cd1bda3ce10419b949ba4746e3546d2.mailgun.org/messages",
    :from => "Mailgun Sandbox <postmaster@sandbox1cd1bda3ce10419b949ba4746e3546d2.mailgun.org>",
    :to => email,
    :subject => "#{domain} has moved out of pendingDelete status",
    :text => "you know what this is you bitch"
end

def register_domain domain
  DNSimple::Client.username = ENV['dnsimple_username']
  DNSimple::Client.api_token = ENV['dnsimple_api_token']
  DNSimple::Client.http_proxy = {}

  registrant = DNSimple::Contact.all.first.id

  DNSimple::Domain.register(domain, { id: registrant })
end
