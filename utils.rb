def hashify (arr)
  hash = {}
  arr.each {|entry| hash[entry.identifier] = entry.restrictions }
  hash
end

def display(hash)
  # puts JSON.pretty_generate(hash)
  hash.keys.sort.each {|k| p k, hash[k]}
end

def load_env_vars
  File.readlines('./.env').map {|line| line.chomp.split("=") }.each do |pair|
    ENV[pair[0]] = pair[1]
  end
end
