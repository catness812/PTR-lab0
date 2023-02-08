defmodule W2 do

  def isPrime(n) when n > 2 do
    Enum.all?(2..(n - 1), fn i -> rem(n, i) != 0 end)
  end
  def isPrime(0), do: false
  def isPrime(1), do: false
  def isPrime(2), do: true

  def cylinderArea(height, radius) do
    2 * :math.pi * radius * (radius + height)
  end

  def reverse(list) do
    Enum.reverse(list)
  end

  def uniqueSum(list) do
    Enum.sum(Enum.uniq(list))
  end

  def extractRandomN(list, n) do
    Enum.take_random(list, n)
  end

  def firstFibonacciElements(n) do
    Enum.take(fibonacci(), n)
  end
  defp fibonacci do
    Stream.unfold([0, 1], &fibonacciUnfold/1)
  end
  defp fibonacciUnfold([a, b]) do
    {a, [b, a + b]}
  end

  def translator(dictionary, original_string) do
    original_string
    |> String.split
    |> Enum.map(&translate(dictionary, &1))
    |> Enum.join(" ")
  end
  defp translate(dictionary, word) do
    case dictionary[word] do
      nil -> word
      translation -> translation
    end
  end

  def smallestNumber(a, b, c) do
    nr = [a, b, c]
    |> Enum.sort()
    if List.starts_with?(nr, [0]) do
      nr1 = List.delete(nr, 0)
      List.insert_at(nr1, 1, 0)
    end
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join()
    |> String.to_integer()
  end

  def rotateLeft(list, n) do
    n = rem(n, length(list))
    list = Enum.drop(list, n) ++ Enum.take(list, n)
    list
  end

  def listRightAngleTriangles(limit) do
    Enum.flat_map(1..limit, &pythagoreanTriples/1)
  end
  defp pythagoreanTriples(a) do
    Enum.filter(1..a, fn b -> _c = is_integer(toInt(:math.sqrt(a**2 + b**2))) end)
    |> Enum.map(fn b -> c = toInt(:math.sqrt(a**2 + b**2))
    {a, b, c} end)
  end
  defp toInt(float) do
    truncated = trunc(float)
    if truncated == float do
      truncated
    else
      float
    end
  end

  def removeConsecutiveDuplicates(list) do
    Enum.dedup(list)
  end

  def lineWords(list) do
    keyboard_rows = [
      "qwertyuiop",
      "asdfghjkl",
      "zxcvbnm"
    ]
    list
    |> Enum.filter(fn word ->
      word = String.downcase(word)
      |> String.graphemes
      |> Enum.uniq
      keyboard_rows
      |> Enum.any?(fn row ->
        Enum.all?(word, fn char -> String.contains?(row, char) end)
      end)
    end)
  end

  def encode(string, n) do
    string
    |> String.to_charlist()
    |> Enum.map(fn char ->
      char < 97 || 97 + rem(char - 71 + n, 26)
    end)
  end

  def decode(string, n) do
    string
    |> String.to_charlist()
    |> Enum.map(fn char ->
      char < 97 || 97 + rem(char - 71 - n, 26)
    end)
  end

  def lettersCombinations(string_of_digits) do
    letters = %{
      "2" => ["a", "b", "c"],
      "3" => ["d", "e", "f"],
      "4" => ["g", "h", "i"],
      "5" => ["j", "k", "l"],
      "6" => ["m", "n", "o"],
      "7" => ["p", "q", "r", "s"],
      "8" => ["t", "u", "v"],
      "9" => ["w", "x", "y", "z"]
    }
    string_of_digits
    |> Enum.map(fn digit ->
      String.graphemes(digit)
      |> Enum.map(&(letters[&1]))
      |> Enum.reduce(fn list, list1 ->
        for i <- list, j <- list1, do: j <> i
      end)
    end)
  end

  def groupAnagrams(list_of_strings) do
    Enum.reduce(list_of_strings, %{}, fn string, map ->
      key = Enum.sort(String.graphemes(string))
      |> Enum.join
      Map.update(map, key, [string], &[string | &1])
    end)
  end

  def commonPrefix(list_of_strings) do
    i = Enum.find_index(0..String.length(Enum.min(list_of_strings)), fn i ->
      String.at(Enum.min(list_of_strings), i) != String.at(Enum.max(list_of_strings), i)
    end)
    String.slice(Enum.min(list_of_strings), 0, i)
  end

  def toRoman(string) do
    arabic = String.to_integer(string)
    roman = [
      {1000, "M"},
      {900, "CM"},
      {500, "D"},
      {400, "CD"},
      {100, "C"},
      {90, "XC"},
      {50, "L"},
      {40, "XL"},
      {10, "X"},
      {9, "IX"},
      {5, "V"},
      {4, "IV"},
      {1, "I"}
    ]
    convert(arabic, roman)
    end
    defp convert(0, _roman), do: ""
    defp convert(number, [{arabic, roman} | tail]) when number >= arabic do
      roman <> convert(number - arabic, [{arabic, roman} | tail])
    end
    defp convert(number, [{arabic, _roman} | tail]) when number < arabic do
      convert(number, tail)
    end

    def factorize(number, start \\ 2)
    def factorize(1, _), do: ""
    def factorize(number, start) when number <= start, do: number
    def factorize(number, start) do
      number
      |> :math.sqrt()
      |> trunc()
      |> max(start)
      |> (&(start..&1)).()
      |> Enum.find_value([number], fn n -> if rem(number, n) == 0, do: [n | factorize(div(number, n), n)] end)
    end

end
