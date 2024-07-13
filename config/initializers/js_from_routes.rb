if Rails.env.development?
  JsFromRoutes.config do |config|
    config.file_suffix = "Api.ts"
  end
end
