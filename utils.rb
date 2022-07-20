def hashify (arr)
  hash = {}
  arr.each {|entry| hash[entry.identifier] = entry.restrictions }
  hash
end

def display(hash)
   hash.keys.sort.each do |k|
     if hash[k].is_a? Array
       puts "\n#{k}: #{hash[k].join(', ')}"
     else
       puts "#{k}:"
       puts "  Only in spreadsheet: #{hash[k][:spreadsheet].join(', ')}" unless hash[k][:spreadsheet].empty?
       puts "  Only in NYPL-Core:   #{hash[k][:github].join(', ')}" unless hash[k][:github].empty?
     end
   end
 end

def load_env_vars
  File.readlines('./.env').map {|line| line.chomp.split("=") }.each do |pair|
    ENV[pair[0]] = pair[1]
  end
end
