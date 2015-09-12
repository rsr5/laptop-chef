
if File.exist?('/usr/bin/dnf')
  execute 'dnf install -y yum' do
    not_if { File.exist?('/usr/bin/yum-deprecated') }
  end
end
