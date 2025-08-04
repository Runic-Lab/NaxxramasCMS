--- Main controller for the `home` module.
-- Defines the `index` function that renders the module's main view.
-- @return table Table of exposed actions.
-- @see applications.modules.home.view.index
home_view = require "applications.modules.home.view.index"

--- Action for the `/` route.
-- Renders the view defined in `home.view.index`.
index = =>
    render: home_view

return {
    index: index
}
