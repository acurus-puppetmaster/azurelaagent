Facter.add(:omsagent) do
    confine :kernel do |value|
        value == "Linux"
    end
    setcode do
        omsagent = {}
        if File.exists?("/opt/microsoft/omsagent/bin/omsadmin.sh")
            omsagent['installed'] = true
        else
            omsagent['installed'] = false
        end
        omsagent
    end
end