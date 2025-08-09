OpenAI.configure do |config|
    config.access_token = ENV.fetch("GITHUB_TOKEN")
    config.uri_base= "https://models.inference.ai.azure.com"
end