defmodule ExOauth2Phoenix.Router do
  @moduledoc """
  Handles routing for ExOauth2Phoenix.
  ## Usage
  Add the following to your `web/router.ex` file
      defmodule MyProject.Router do
        use MyProject.Web, :router
        use ExOauth2Phoenix.Router         # Add this
        scope "/oauth" do
          pipe_through :protected
          oauth_routes()                    # Add this
        end
        # ...
      end
  Alternatively, you may want to use the login plug in individual controllers. In
  this case, you can have one pipeline, one scope and call `oauth_routes :all`.
  In this case, it will add both the public and protected routes.
  """

  alias ExOauth2Phoenix.AuthorizationController
  alias ExOauth2Phoenix.ApplicationController

  defmacro __using__(_opts \\ []) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @doc """
  ExOauth2Phoenix Router macro.
  Use this macro to define the various ExOauth2Phoenix Routes.
  ## Examples:
      # Routes requires authentication
      scope "/oauth" do
        pipe_through :protected
        oauth_routes()
      end
  """
  defmacro oauth_routes() do
    quote location: :keep do
      options = %{scope: "oauth"}

      scope "/#{options[:scope]}", as: "oauth" do
        scope "/authorize" do
          get "/", AuthorizationController, :new
          post "/", AuthorizationController, :create
          get "/:code", AuthorizationController, :show
          delete "/", AuthorizationController, :delete
        end
        resources "/applications", ApplicationController, param: "uid"
        # resources "/authorized_applications", AuthorizedApplicationController, only: [:index, :destroy]
        # post "/token", TokenController, :create
        # post "/revoke", TokenController, :revoke
        # get "/token/info", TokenInfoController, :show
      end
    end
  end
end
