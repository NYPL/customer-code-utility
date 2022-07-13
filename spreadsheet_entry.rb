require_relative 'customer_code_entries'
require 'csv'

class SpreadSheetEntry < CustomerCodeEntry

  def self.from(line)
    begin
      columns = CSV.parse_line line
    rescue StandardError => e
      nil
    end
    return nil unless columns
    customer_code = columns[0]
    owning_institution = columns[1]
    restrictions = is_nypl?(owning_institution) ? extract_code(columns[3]) : extract_code(columns[9])
    super(customer_code, owning_institution, restrictions)
  end

  def self.from_file
    File
      .readlines(ENV['SPREADSHEET_FILE'])
      .map {|line| from(line) }
      .compact
  end

  def self.extract_code(str)
    (str || "").split(/\W/).filter {|code| code != ""}
  end

end
