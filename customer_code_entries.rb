class CustomerCodeEntry

  @@institutions = [
    "PRINCETON",
    "COLUMBIA",
    "NEW YORK",
    "HARVARD"
  ]

  attr_accessor :customer_code, :owning_institution, :restrictions

  def initialize(customer_code, owning_institution, restrictions)
    @customer_code = customer_code
    @owning_institution = owning_institution
    @restrictions = restrictions
  end

  def is_nypl?
    self.class.is_nypl? owning_institution
  end

  def self.validate(customer_code, owning_institution, restrictions)
    is_code? (customer_code) &&
    @@institutions.include? (owning_institution) &&
    restrictions.all? {|code| is_code? code }
  end

  def self.is_code?(str)
    str.match(/^\w{2,3}$/)
  end

  def self.is_nypl?(institution)
    institution == 'NEW YORK'
  end

  def self.from(customer_code, owning_institution, restritions)
    validate(customer_code, owning_institution, restritions) ? new(customer_code, owning_institution, restritions) : nil
  end
end
