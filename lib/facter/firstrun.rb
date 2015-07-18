#facter.rb

Facter.add("firstrun") do
  setcode do
    if File.exists? '/etc/.firstrun'
      "true"
    else
      "false"
    end
  end
end
