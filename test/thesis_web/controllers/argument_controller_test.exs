defmodule ThesisWeb.ArgumentControllerTest do
  use ThesisWeb.ConnCase

  alias Thesis.Claims

  @create_attrs %{type: "some type"}
  @update_attrs %{type: "some updated type"}
  @invalid_attrs %{type: nil}

  def fixture(:argument) do
    {:ok, argument} = Claims.create_argument(@create_attrs)
    argument
  end

  describe "index" do
    test "lists all arguments", %{conn: conn} do
      conn = get conn, argument_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Arguments"
    end
  end

  describe "new argument" do
    test "renders form", %{conn: conn} do
      conn = get conn, argument_path(conn, :new)
      assert html_response(conn, 200) =~ "New Argument"
    end
  end

  describe "create argument" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, argument_path(conn, :create), argument: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == argument_path(conn, :show, id)

      conn = get conn, argument_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Argument"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, argument_path(conn, :create), argument: @invalid_attrs
      assert html_response(conn, 200) =~ "New Argument"
    end
  end

  describe "edit argument" do
    setup [:create_argument]

    test "renders form for editing chosen argument", %{conn: conn, argument: argument} do
      conn = get conn, argument_path(conn, :edit, argument)
      assert html_response(conn, 200) =~ "Edit Argument"
    end
  end

  describe "update argument" do
    setup [:create_argument]

    test "redirects when data is valid", %{conn: conn, argument: argument} do
      conn = put conn, argument_path(conn, :update, argument), argument: @update_attrs
      assert redirected_to(conn) == argument_path(conn, :show, argument)

      conn = get conn, argument_path(conn, :show, argument)
      assert html_response(conn, 200) =~ "some updated type"
    end

    test "renders errors when data is invalid", %{conn: conn, argument: argument} do
      conn = put conn, argument_path(conn, :update, argument), argument: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Argument"
    end
  end

  describe "delete argument" do
    setup [:create_argument]

    test "deletes chosen argument", %{conn: conn, argument: argument} do
      conn = delete conn, argument_path(conn, :delete, argument)
      assert redirected_to(conn) == argument_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, argument_path(conn, :show, argument)
      end
    end
  end

  defp create_argument(_) do
    argument = fixture(:argument)
    {:ok, argument: argument}
  end
end
