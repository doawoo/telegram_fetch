defmodule TelegramFetch do
  require Logger

  alias TelegramFetch.TelegramInfo

  @meta_keys ["og:description", "og:image", "og:title"]

  @spec fetch_by_username(binary()) :: {:ok, TelegramInfo.t()} | {:error, atom()}
  def fetch_by_username(username) do
    url = "https://t.me/#{username}"
    result = case Tesla.get(url) do
      {:ok, resp} -> parse_user_resp(resp.body)
      {:error, reason} ->
        Logger.error("Failed to fetch for username #{username} | reason: #{inspect(reason)}")
        {:error, :fetch_failed}
    end

    if is_map(result) do
      {:ok, %TelegramInfo{
        username: username,
        display_name: result.title,
        avatar: result.image,
        bio: result.description
      }}
    else
      result
    end
  end

  defp parse_user_resp(resp_body) do
    case Floki.parse_fragment(resp_body) do
      {:ok, parsed} -> extract_meta(parsed)
      {:error, reason} ->
        Logger.error("Failed to parse HTML: #{inspect(reason)}")
        {:error, :floki_parse_failed}
    end
  end

  defp extract_meta(floki_parsed) do
    data = floki_parsed
      |> Floki.find("meta")
      |> Enum.filter(fn tag -> match?({"meta", [{"property", _}, {"content", _}], []}, tag) end)
      |> Enum.reduce(%{}, fn {"meta", [{"property", key}, {"content", content}], []}, acc ->
        if key in @meta_keys do
          atom_key = String.split(key, ":") |> List.last() |> String.to_atom()
          Map.put_new(acc, atom_key, content)
        else
          acc
        end
      end)

      data
  end

end
