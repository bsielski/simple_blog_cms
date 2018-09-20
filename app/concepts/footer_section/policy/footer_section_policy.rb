class FooterSectionPolicy
  def initialize(admin, model)
    @admin = admin
    @model = model.is_a?(Array) ? model.last : model
  end

  def create?
    return false if @admin.nil?
    @admin.has_role? :super_admin or @admin.has_role? :can_create_footer_sections
  end

  def update?
    return false if @admin.nil?
    @admin.has_role? :super_admin or @admin.has_role? :can_update_footer_sections
  end

  def destroy?
    return false if @admin.nil?
    @admin.has_role? :super_admin or @admin.has_role? :can_destroy_footer_sections
  end
end
