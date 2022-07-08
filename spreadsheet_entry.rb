require_relative 'customer_code_entries'

class SpreadSheetEntry < CustomerCodeEntry

  def self.from(line)
    columns = line.split(",")
    customer_code = columns[0]
    owning_institution = columns[1]
    delivery_restrictions = extract_code columns[3]
    new_york_cross_partner_delivery_restrictions = extract_code columns[9]
    restritions = is_nypl? ? delivery_restrictions : new_york_cross_partner_delivery_restrictions
    super(customer_code, owning_institution, restrictions)
  end

  def self.extract_code(str)
    str.split(/\W/).filter {|code| code != ""}
  end

end
