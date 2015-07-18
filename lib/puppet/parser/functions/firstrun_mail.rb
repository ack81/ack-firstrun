#firsturn_mail.rb

require 'puppet'
require 'pp'
require 'net/smtp'

module Puppet::Parser::Functions
  newfunction(:firstrun_mail) do |args|
    is_firstrun = lookupvar('firstrun')
    mail_from = args[0]
    mail_to = args[1]
    mail_subject = args[2]
    mail_template = args[3]
    mail_type = "MIME-Version: 1.0\nContent-type: text/html"
    mail_header = "From: #{mail_from}\nTo: #{mail_to}\nSubject: #{mail_subject}\n#{mail_type}"
    mail_body = "#{mail_header}\n\n#{mail_template}"
    if is_firstrun == 'true'
      begin
        Net::SMTP.start('localhost', 25) do |smtpclient|
          smtpclient.send_message(mail_body, mail_from, mail_to)
        end
      rescue Exception => err
        print "Exception occured: " + err
      end
    elsif is_firstrun != 'true'
	end
  end
end
