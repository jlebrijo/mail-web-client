class AddImapPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :imap_password, :string
  end
end
