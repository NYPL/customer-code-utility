require('net/http')
require('json')
require_relative('spreadsheet_entry')
require_relative('github_entry')

spreadsheet_codes = File
  .readlines(ENV['SPREADSHEET_FILE'])
  .map {|line| SpreadSheetEntry.from(line) }
  .compact

github_codes = JSON.parse(
    Net::HTTP.get(URI(ENV['GITHUB_URL']))
  )['@graph']
  .map { |entry| GitHubEntry.from(entry) }
