class Admin < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :authors
  has_many :articles, through: :authors
  after_create :set_roles_for_a_new_admin

  scope :without_role, ->(role) do
    where.not(id: Role.find_by(name: role.to_s).admins.pluck(:id))
  end

  private

  def set_roles_for_a_new_admin
    unless self.id == 1
      self.add_role :can_create_stylesheets
      self.add_role :can_create_header_sections
      self.add_role :can_create_footer_sections

      self.add_role :can_create_articles
      self.add_role :can_edit_own_articles
      self.add_role :can_create_own_authors
      self.add_role :can_edit_own_authors
    end
  end

end
