require 'active_imap'
ActiveImap.configure do |config|
  config.server = {
    :host => 'mail.lebrijo.com',
    :port => 143,
    :ssl => false
  }
end