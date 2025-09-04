RubyLLM.configure do |config|
  config.openai_api_key = ENV["GITHUB_TOKEN"]
  # config.openai_api_base = "https://api.groq.com/openai/v1" 
  config.openai_api_base = "https://models.inference.ai.azure.com"
  # config.default_model = "openai/gpt-oss-20b" for groq
end