class ApplicationPolicy

  attr_reader :admin, :record

  def initialize(admin, record)
    @admin   = admin
    @record = record
  end

end
