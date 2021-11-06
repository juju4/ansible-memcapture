require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('ls -al /tmp/cases/*-incidentreport/*-memory-linpmem.aff4') do
  its(:stdout) { should match /aff4/ }
## FIXME! undefined method `size' for #<Serverspec::Type::Command:0x00000002c09b38>
#  its(:size) { should > 0 }
end

describe command('ls -al /tmp/cases/*-incidentreport/capture/*/*-memory.lime') do
  its(:stdout) { should match /lime/ }
#  its(:size) { should > 0 }
end

#describe command('ls -al /tmp/cases/*-incidentreport/capture/*/*-profile.zip') do
#  its(:stdout) { should match /profile.zip/ }
#  its(:size) { should > 0 }
#end

## FIXME! readable by volatility?
