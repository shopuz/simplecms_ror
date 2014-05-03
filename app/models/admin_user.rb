class AdminUser < ActiveRecord::Base
	# to configure a different table name because user table is renamed to admin_user table in alter_user migration
	# self.table_name = "admin_users"

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections , :through => :section_edits
end
