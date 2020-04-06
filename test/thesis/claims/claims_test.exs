defmodule Thesis.ClaimsTest do
  use Thesis.DataCase

  alias Thesis.Claims

  describe "claims" do
    alias Thesis.Claims.Claim

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def claim_fixture(attrs \\ %{}) do
      {:ok, claim} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Claims.create_claim()

      claim
    end

    test "list_claims/0 returns all claims" do
      claim = claim_fixture()
      assert Claims.list_claims() == [claim]
    end

    test "get_claim!/1 returns the claim with given id" do
      claim = claim_fixture()
      assert Claims.get_claim!(claim.id) == claim
    end

    test "create_claim/1 with valid data creates a claim" do
      assert {:ok, %Claim{} = claim} = Claims.create_claim(@valid_attrs)
      assert claim.content == "some content"
    end

    test "create_claim/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Claims.create_claim(@invalid_attrs)
    end

    test "update_claim/2 with valid data updates the claim" do
      claim = claim_fixture()
      assert {:ok, claim} = Claims.update_claim(claim, @update_attrs)
      assert %Claim{} = claim
      assert claim.content == "some updated content"
    end

    test "update_claim/2 with invalid data returns error changeset" do
      claim = claim_fixture()
      assert {:error, %Ecto.Changeset{}} = Claims.update_claim(claim, @invalid_attrs)
      assert claim == Claims.get_claim!(claim.id)
    end

    test "delete_claim/1 deletes the claim" do
      claim = claim_fixture()
      assert {:ok, %Claim{}} = Claims.delete_claim(claim)
      assert_raise Ecto.NoResultsError, fn -> Claims.get_claim!(claim.id) end
    end

    test "change_claim/1 returns a claim changeset" do
      claim = claim_fixture()
      assert %Ecto.Changeset{} = Claims.change_claim(claim)
    end
  end

  describe "arguments" do
    alias Thesis.Claims.Argument

    @valid_attrs %{type: "some type"}
    @update_attrs %{type: "some updated type"}
    @invalid_attrs %{type: nil}

    def argument_fixture(attrs \\ %{}) do
      {:ok, argument} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Claims.create_argument()

      argument
    end

    test "list_arguments/0 returns all arguments" do
      argument = argument_fixture()
      assert Claims.list_arguments() == [argument]
    end

    test "get_argument!/1 returns the argument with given id" do
      argument = argument_fixture()
      assert Claims.get_argument!(argument.id) == argument
    end

    test "create_argument/1 with valid data creates a argument" do
      assert {:ok, %Argument{} = argument} = Claims.create_argument(@valid_attrs)
      assert argument.type == "some type"
    end

    test "create_argument/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Claims.create_argument(@invalid_attrs)
    end

    test "update_argument/2 with valid data updates the argument" do
      argument = argument_fixture()
      assert {:ok, argument} = Claims.update_argument(argument, @update_attrs)
      assert %Argument{} = argument
      assert argument.type == "some updated type"
    end

    test "update_argument/2 with invalid data returns error changeset" do
      argument = argument_fixture()
      assert {:error, %Ecto.Changeset{}} = Claims.update_argument(argument, @invalid_attrs)
      assert argument == Claims.get_argument!(argument.id)
    end

    test "delete_argument/1 deletes the argument" do
      argument = argument_fixture()
      assert {:ok, %Argument{}} = Claims.delete_argument(argument)
      assert_raise Ecto.NoResultsError, fn -> Claims.get_argument!(argument.id) end
    end

    test "change_argument/1 returns a argument changeset" do
      argument = argument_fixture()
      assert %Ecto.Changeset{} = Claims.change_argument(argument)
    end
  end
end
