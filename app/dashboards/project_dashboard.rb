require "administrate/base_dashboard"

class ProjectDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    user: Field::BelongsTo,
    invoice: Field::HasOne,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    amount_cents: Field::Number,
    client_email: Field::String,
    url: Field::String,
    client_first_name: Field::String,
    client_last_name: Field::String,
    message: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    documents_count: Field::Number,
    status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    payment_status: Field::Select.with_options(searchable: false, collection: ->(field) { field.resource.class.send(field.attribute.to_s.pluralize).keys }),
    slug: Field::String,
    discount: Field::Number.with_options(decimals: 2),
    spayce_commission: Field::Number.with_options(decimals: 2),
    tax: Field::Number.with_options(decimals: 2),
    total: Field::Number.with_options(decimals: 2),
    zipped_key: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  user
  created_at
  updated_at
  invoice
  status
  payment_status
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  user
  invoice
  id
  name
  description
  amount_cents
  client_email
  url
  client_first_name
  client_last_name
  message
  created_at
  updated_at
  documents_count
  status
  payment_status
  discount
  spayce_commission
  tax
  total
  zipped_key
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  user
  name
  description
  amount_cents
  client_email
  url
  client_first_name
  client_last_name
  message
  documents_count
  discount
  spayce_commission
  tax
  total
  zipped_key
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

  # Overwrite this method to customize how projects are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(project)
  #   "Project ##{project.id}"
  # end

  def permitted_attributes
    super + [:attachments => []]
  end
end
