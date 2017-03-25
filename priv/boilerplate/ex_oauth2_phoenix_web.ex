defmodule <%= base %>.ExOauth2Phoenix.Web do
  @moduledoc false

  def view do
    quote do
      use Phoenix.View, root: "web/templates/ex_oauth2_phoenix"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import <%= base %>.Router.Helpers
      import <%= base %>.ErrorHelpers
      import <%= base %>.Gettext
      import <%= base %>.ExOauth2Phoenix.ViewHelpers
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
