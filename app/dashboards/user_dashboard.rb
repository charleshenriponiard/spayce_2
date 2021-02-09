require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    projects: Field::HasMany,
    id: Field::Number,
    email: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    uid: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    admin: Field::Boolean,
    country: Field::String,
    confirmed_at: Field::DateTime,
    verification_status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    verified_status_alert: Field::Boolean,
    confirmation_sent_at: Field::DateTime,
    siret: Field::String,
    address_line1: Field::String,
    address_line2: Field::String,
    zipcode: Field::String,
    city: Field::String,
    state: Field::String,
    entity_name: Field::String
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  projects
  id
  email
  confirmation_sent_at
  verification_status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  projects
  id
  email
  created_at
  updated_at
  uid
  first_name
  last_name
  admin
  country
  confirmed_at
  verification_status
  verified_status_alert
  siret
  address_line1
  address_line2
  zipcode
  city
  state
  entity_name
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  email
  first_name
  last_name
  siret
  address_line1
  address_line2
  zipcode
  city
  state
  entity_name
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(user)
    "#{user.first_name} - #{user.last_name}"
  end
end
