defmodule ThesisWeb.ClaimView do
  use ThesisWeb, :view
  alias Thesis.Claims
  alias Thesis.Claims.Claim

  def type_class(type) do
    %{1 => "default", 2 => "secondary"}[type]
  end
end
