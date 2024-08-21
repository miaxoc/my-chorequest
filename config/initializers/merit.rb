# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  config.checks_on_each_request = true

  # Add application observers to get notifications when reputation changes.
  # config.add_observer 'MyObserverClassName'

  # Define :user_model_name. This model will be used to grant badge if no
  # `:to` option is given. Default is 'User'.
  # config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  # config.current_user_method = 'current_user'
end

Rails.application.reloader.to_prepare do

  Merit::Badge.create(
    id: 1,
    name: "first-submission",
    description: "Awarded for making your first task submission"
  )

  Merit::Badge.create(
    id: 2,
    name: "five-submissions",
    description: "Awarded for making five task submissions"
  )
end
