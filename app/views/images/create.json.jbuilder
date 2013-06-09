json.array!([@image]) do |json, image|
  json.name            		image.info
  json.size            		image.info.size
  json.current_path  		image.info.current_path
  json.url           		image.info.url
  json.thumbnail_url   		image.info.url(:thumb)
end
