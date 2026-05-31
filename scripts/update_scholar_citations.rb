#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "net/http"
require "uri"

ROOT = File.expand_path("..", __dir__)
SOCIALS_PATH = File.join(ROOT, "_data", "socials.yml")

def read_socials
  File.read(SOCIALS_PATH)
end

def extract_social_value(content, key)
  match = content.match(/^#{Regexp.escape(key)}:\s*["']?([^"'\s#]+(?:\s[^#]+?)?)["']?\s*(?:#.*)?$/)
  match && match[1].strip
end

def fetch_scholar_profile(user_id)
  uri = URI("https://scholar.google.com/citations?user=#{URI.encode_www_form_component(user_id)}&hl=en")
  request = Net::HTTP::Get.new(uri)
  request["User-Agent"] = "Mozilla/5.0 (compatible; jwwangchn.github.io citation updater)"

  Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 20, open_timeout: 10) do |http|
    response = http.request(request)
    unless response.is_a?(Net::HTTPSuccess)
      raise "Google Scholar returned HTTP #{response.code}"
    end
    response.body
  end
end

def extract_citation_count(html)
  description = html[/<meta name="description" content="([^"]+)"/, 1]
  description ||= html[/<meta property="og:description" content="([^"]+)"/, 1]
  raise "Could not find Google Scholar description metadata" unless description

  count = description[/Cited by ([\d,]+)/, 1]
  raise "Could not parse citation count from Google Scholar metadata" unless count

  count
end

def upsert_yaml_value(content, key, value, comment = nil)
  line = %(#{key}: "#{value}")
  line = "#{line} # #{comment}" if comment

  if content.match?(/^#{Regexp.escape(key)}:/)
    content.sub(/^#{Regexp.escape(key)}:.*$/, line)
  else
    "#{content.chomp}\n#{line}\n"
  end
end

content = read_socials
user_id = ENV["SCHOLAR_USER_ID"] || extract_social_value(content, "scholar_userid")
raise "Missing scholar_userid in #{SOCIALS_PATH}" if user_id.nil? || user_id.empty?

html = fetch_scholar_profile(user_id)
citations = extract_citation_count(html)
updated = Date.today.strftime("%B %-d, %Y")

content = upsert_yaml_value(content, "scholar_citations", citations, "total Google Scholar citations, update manually when needed")
content = upsert_yaml_value(content, "scholar_citations_updated", updated)

File.write(SOCIALS_PATH, content)
puts "Google Scholar citations: #{citations} (updated #{updated})"
