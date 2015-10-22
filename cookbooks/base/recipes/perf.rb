
# Install some of Brendan Gregg's Linux performance tools.
# https://github.com/brendangregg/perf-tools

remote_file '/usr/bin/opensnoop' do
  source 'https://raw.githubusercontent.com/brendangregg/perf-tools/'\
         'cea905d41771479f44ce01165e0dd4e3fc166b3a/opensnoop'
  mode '0755'
end

remote_file '/usr/bin/execsnoop' do
  source 'https://raw.githubusercontent.com/brendangregg/perf-tools/'\
         'cea905d41771479f44ce01165e0dd4e3fc166b3a/execsnoop'
  mode '0755'
end
