require_relative 'customer_code_entries'

class GitHubEntry < CustomerCodeEntry

  def self.from(entry)
    customer_code = extract_code entry
    owning_institution = get_owner entry
    restrictions = entry["nypl:deliverableTo"].map {|item| extract_code item}
    super(customer_code, owning_institution, restrictions)
  end

  def self.extract_codes(obj)
    obj["@id"].split("/").last
  end

  def self.get_owner(obj)
    obj["nypl:owner"] &&
    obj["nypl:owner"]["@id"] &&
    {
      "0001" => "NEW YORK",
      "0002" => "COLUMBIA",
      "0003" => "PRINCETON",
      "0004" => "HARVARD"
    }[obj["nypl:owner"]["@id"].split(":").last]
  end

end
