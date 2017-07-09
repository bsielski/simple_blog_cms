class Admin < ApplicationRecord
  rolify #after_add: :remove_role_if_super_admin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :authors
  has_many :articles, through: :authors
  after_create :set_roles_for_a_new_admin

  private

  def remove_role_if_super_admin(role)
    if self.has_role? :super_admin
      roles = self.roles.to_a.map{|role| role.name}
      roles.delete "super_admin"
      roles.each do |role|
        self.remove_role role
      end
    end
  end

  def set_roles_for_a_new_admin
    unless self.has_role? :super_admin
      self.add_role :can_create_stylesheets
      self.add_role :can_create_header_sections
      self.add_role :can_create_footer_sections

    end
  end

end
