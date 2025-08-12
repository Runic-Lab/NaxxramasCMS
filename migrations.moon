schema = require "lapis.db.schema"
types = schema.types

return {
  ["1755018878"]: ->
    schema.create_table "news", {
      { "id", types.integer }
      { "title", types.text }
      { "content", types.text }
      { "slug", types.varchar }
      { "image", types.varchar null: true }
      { "created_at", types.time }
      { "updated_at", types.time null: true }
      { "author_id", types.integer }
      
      "PRIMARY KEY (id)"
      "UNIQUE KEY unique_slug (slug)"
      "KEY author_id_index (author_id)"
    }
}