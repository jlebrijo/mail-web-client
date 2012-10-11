class SmtpMessage #< ActiveRecord::Base
#  include ActiveModel::AttributeMethods
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
#  extend ActiveModel::Callbacks
#  extend ActiveModel::Translation
#  include ActiveModel::Serialization
  attr_accessor :body, :subject, :to
  def persisted?
    @persisted ||= false
  end
end
