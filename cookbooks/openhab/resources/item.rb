actions :create
default_action :create

item_types = %w(
  Call
  Color
  Contact
  DateTime
  Dimmer
  Group
  Location
  Number
  Rollershutter
  String
  Switch
)

attribute :name, kind_of: String, name_attribute: true
attribute :type, kind_of: String, default: 'DateTime', equal_to: item_types
attribute :filename, kind_of: String, default: 'default'
attribute :label, kind_of: String, default: nil
attribute :binding, kind_of: String, default: nil
attribute :icon, kind_of: String, default: nil
attribute :groups, kind_of: Array, default: []
