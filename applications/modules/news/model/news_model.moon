import Model from require "lapis.db.model"

class News extends Model
    @primary_key: "id"

    @get_by_id: (id) =>
        return News\find id

    @get_latest: (limit) =>
        return News\select "ORDER BY created_at DESC LIMIT #{limit}"

    @get_all: =>
        return News\select "ORDER BY created_at DESC"

    @get_by_slug: (slug) =>
        return News\select "WHERE slug = '#{slug}'"

    get_id: =>
        return @id

    get_title: =>
        return @title

    get_content: =>
        return @content

    get_slug: =>
        return @slug

    get_created_at: =>
        return @created_at
