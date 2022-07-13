require('net/http')
require('json')
require_relative('spreadsheet_entry')
require_relative('github_entry')
require_relative('utils')

load_env_vars

spreadsheet_codes = SpreadSheetEntry.from_file
spreadsheet_hash = hashify(spreadsheet_codes)

github_codes = GitHubEntry.from_url
github_hash = hashify(github_codes)


diff = Hash.new {|h,k| h[k] = []}

spreadsheet_codes.each do |entry|
  identifier = entry.identifier
  unless github_hash[identifier]
    diff["present_on_spreadsheet_only"].push(identifier)
  else
    difference = {
      spreadsheet: spreadsheet_hash[identifier] - github_hash[identifier],
      github: github_hash[identifier] - spreadsheet_hash[identifier]
    }
    diff[identifier] = difference if difference[:spreadsheet].length > 0 || difference[:github].length > 0
  end
end

# p 'spreadsheet_hash'
# display spreadsheet_hash

github_codes.each do |entry|
  identifier = entry.identifier
  diff["present_on_github_only"].push(identifier) unless spreadsheet_hash[identifier]
end

# p 'github_hash'
# display github_hash

display diff
