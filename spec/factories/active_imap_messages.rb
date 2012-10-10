# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :active_imap_message do
    subject "MyString"
    from ""
    sender ""
    to ""
    date "2012-10-10"
    text_content "MyText"
  end
end
