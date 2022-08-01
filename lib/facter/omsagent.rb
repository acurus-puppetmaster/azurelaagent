Facter.add(:omsagent) do
    confine :kernel => :linux
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