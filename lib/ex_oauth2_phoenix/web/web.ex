defmodule ExOauth2Phoenix.Web do
  @moduledoc """
  ExOauth2Phoenix setting for web resources.

  Similar to a project's Web module
  """

  @doc false
  def controller do
    quote do
      use Phoenix.Controller

      import ExOauth2Phoenix.Web.Gettext
    end
  end

  @doc false
  def router do
    quote do
      use Phoenix.Router
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
