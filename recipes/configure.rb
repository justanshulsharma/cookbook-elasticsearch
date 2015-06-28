require 'resolv'

# Create ES config file
#
template "configure_elasticsearch.yml" do
  path   "#{node.elasticsearch[:path][:conf]}/elasticsearch.yml"
  source node.elasticsearch[:templates][:elasticsearch_yml]
  owner  node.elasticsearch[:user] and group node.elasticsearch[:user] and mode 0755

  variables(
    nodes: search(:node, "name:*")
  )

  notifies :restart, 'service[elasticsearch]'
end
