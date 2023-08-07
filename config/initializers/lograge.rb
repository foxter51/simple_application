Rails.application.configure do
  config.lograge.custom_options = lambda do |event|
    { time: event.time }
  end
end
