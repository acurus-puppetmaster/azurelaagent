Facter.add(:omsagent) do
    confine :kernel do |value|
        value == "Linux"
    end
    setcode do
        omsagent_hash = {}
        if File.exists?("/opt/microsoft/omsagent/bin/omsadmin.sh") do
            omsagent_hash['installed'] = true
        else
            omsagent_hash['installed'] = false
        end
        omsagent_hash
    end
end