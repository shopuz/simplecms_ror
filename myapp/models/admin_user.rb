class AdminUser < ActiveRecord::Base
	# to configure a different table name because user table is renamed to admin_user table in alter_user migration
	# self.table_name = "admin_users"
  
  has_secure_password

	has_and_belongs_to_many :pages
	has_many :section_edits
	has_many :sections , :through => :section_edits

	EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i
  	
  	FORBIDDEN_USERNAMES = ['littlebopeep']
  # validates_presence_of :first_name
  # validates_length_of :first_name, :maximum => 25
  # validates_presence_of :last_name
  # validates_length_of :last_name, :maximum => 50
  # validates_presence_of :username
  # validates_length_of :username, :within => 8..25
  # validates_uniqueness_of :username
  # validates_presence_of :email
  # validates_length_of :email, :maximum => 100
  # validates_format_of :email, :with => EMAIL_REGEX
  # validates_confirmation_of :email

  # shortcut validations, aka "sexy validations"
  validates :first_name, :presence => true,
                         :length => { :maximum => 25 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 50 }
  validates :username, :length => { :within => 8..25 },
                       :uniqueness => true
  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :confirmation => true
   validate :username_is_allowed

   scope :sorted, lambda { order("last_name ASC , first_name ASC")}

   
   def username_is_allowed
   	if FORBIDDEN_USERNAMES.include?(username) 
   		errors.add(:username, 'restricted user name')
   	end
   end


   def name
    "#{first_name} #{last_name}"
   end

end
