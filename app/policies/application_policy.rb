class ApplicationPolicy

  attr_reader :admin, :record

  def initialize(admin, record)
    @admin   = admin
    @record = record.is_a?(Array) ? record.last : record
  end

end
