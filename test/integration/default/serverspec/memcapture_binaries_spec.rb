require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/tmp/ir-bin/volatility/vol.py') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe file('/tmp/ir-bin/linpmem-2.1.post4') do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'root' }
end

describe file('/tmp/ir-bin/lmg/lmg') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe file('/tmp/ir-bin/LiME/src/lime.o') do
  it { should be_file }
  it { should be_owned_by 'root' }
end
