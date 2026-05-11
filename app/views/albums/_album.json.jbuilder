json.call(album, :id, :name, :year, :genre, :artist_id)
json.artist_name album.artist.name
json.cover_image_url do
  json.small URI.join(root_url, cover_image_url_for(album, size: :small))
  json.medium URI.join(root_url, cover_image_url_for(album, size: :medium))
  json.large URI.join(root_url, cover_image_url_for(album, size: :large))
end
