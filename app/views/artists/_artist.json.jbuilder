json.call(artist, :id, :name)
json.is_various artist.various
json.image_urls do
  json.small URI.join(root_url, cover_image_url_for(artist, size: :small))
  json.medium URI.join(root_url, cover_image_url_for(artist, size: :medium))
  json.large URI.join(root_url, cover_image_url_for(artist, size: :large))
end
