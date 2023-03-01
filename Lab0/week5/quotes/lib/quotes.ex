defmodule Quotes do
  import Jason

  def get do
    case HTTPoison.get("https://quotes.toscrape.com/") do
      {:ok, %HTTPoison.Response{status_code: status_code, headers: headers, body: body}} ->
        IO.puts("HTTP Status Code: #{status_code}")
        IO.puts("HTTP Response Headers:")
        Enum.each(headers, fn {key, value} ->
          IO.puts("#{key}: #{value}")
        end)

        quotes =
          body
          |> Floki.find(".quote")
          |> Enum.map(fn quote ->
            %{
              Quote: Floki.find(quote, ".text") |> Floki.text |> String.replace("“", "") |> String.replace("”", ""),
              Author: Floki.find(quote, ".author") |> Floki.text,
              Tags: Floki.find(quote, ".tags a") |> Floki.text(sep: ", ")
            }
          end)

        quotes_json = encode_to_iodata!(quotes, pretty: true)
        File.write("lib/quotes.json", quotes_json)

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        IO.puts("HTTP Status Code: #{status_code}")
        {:error, "Not Found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
