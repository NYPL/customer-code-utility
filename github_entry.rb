require('net/http')
require('json')
require_relative 'customer_code_entries'

class GitHubEntry < CustomerCodeEntry

  def self.from(entry)
    return nil unless valid?(entry)
    customer_code = extract_code entry
    owning_institution = get_owner entry
    deliverableTo = (dTo = entry["nypl:deliverableTo"]).is_a?(Array) ? dTo : (dTo ? [dTo] : [])
    restrictions = deliverableTo.map {|item| extract_code item}
    super(customer_code, owning_institution, restrictions)
  end

  def self.from_url
    JSON.parse(
        Net::HTTP.get(URI(ENV['GITHUB_URL']))
      )['@graph']
      .map { |entry| from(entry) }
      .compact
  end

  def self.valid?(entry)
    entry['@id'] &&
    entry['nypl:owner'] &&
    entry['nypl:owner']['@id']
  end

  def self.extract_code(obj)
    obj["@id"].split("/").last
  end

  def self.get_owner(obj)
    {
      "0001" => "NEW YORK",
      "0002" => "COLUMBIA",
      "0003" => "PRINCETON",
      "0004" => "HARVARD"
    }[obj["nypl:owner"]["@id"].split(":").last]
  end

end
