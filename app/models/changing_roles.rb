require 'set'

class ChangingRoles
  attr_reader :roles_to_take_away
  attr_reader :roles_to_give

  def initialize(admin_roles, role_ids_from_params)
    @admin_roles = admin_roles.map{|role| role.name}.to_set
    @params_roles = role_ids_from_params.select{|id| !id.empty?}.map{|id| Role.find(id).name}.to_set

    @roles_to_take_away = (@admin_roles - @params_roles).to_a
    @roles_to_give = (@params_roles - @admin_roles).to_a
    puts "CHANGES!"
    puts "REMOVED: #{@roles_to_take_away.inspect}"
    puts "ADDED: #{@roles_to_give.inspect}"
  end

end
