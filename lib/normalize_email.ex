defmodule NormalizeEmail do
  @moduledoc """
  The base module of NormalizeEmail.

  It exposes a primary function, `normalize_email`, and a few utils.
  """

  @doc """
  Normalizes an email. This is useful for storing, comparing, etc.

  Args:

  * `email` - the email to normalize, string

  Returns a normalized email as a string.
  """
  def normalize_email(email) do
    if IsEmail.validate(email) do
      email
      |> String.replace(~r/\+(.*)@/, "@")
      |> normalize_dots()
      |> normalize_domains()
      |> String.downcase()
    else
      email
    end
  end

  @doc """
  Normalizes an domain by replacing it with a common domain.

  Args:

  * `email` - the email to check, string

  Returns an email.
  """

  def normalize_domains(email),
    do: String.replace(email, ~r/googlemail\.com$/, "gmail.com")

  @doc """
  Normalizes `.` emails.

  Args:

  * `email` - the email to check, string

  Returns an email.
  """
  def normalize_dots(email) do
    [username, domain] = get_email_parts(email)

    if String.match?(domain, ~r/^(live\.com|gmail\.com|googlemail\.com)$/) do
      email = String.replace(username, ~r/\./, "") <> "@" <> domain
    else
      email
    end
  end

  @doc """
  Split an email to a username and domain parts.

  Args:

  * `email` - the email to split, string

  Returns a two string `List` -- `[username, domain]`.
  """
  def get_email_parts(email) do
    String.split(email, "@", parts: 2)
  end
end
