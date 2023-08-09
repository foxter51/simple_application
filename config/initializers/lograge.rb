Rails.application.configure do
  config.lograge.custom_options = lambda do |event|
    exceptions = %w[controller action format id]
    {
      time: event.time,

      params: event.payload[:params].except(*exceptions),

      exception: event.payload[:exception]&.first,
      exception_message: event.payload[:exception]&.last.to_s,
      exception_backtrace: event.payload[:exception_object]&.backtrace&.join(",")
    }.compact
  end
end
