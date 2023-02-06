defmodule W2 do

  def isPrime(n) do
    if n == 0 || n == 1 || n == 2 do
      false
    else
      Enum.all?(2..(n - 1), fn i -> rem(n, i) != 0 end)
    end
  end

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

  # currently not working
  def listRightAngleTriangles(limit) do
    Enum.flat_map(1..limit, &generate_triple/1)
  end
  defp generate_triple(a) do
    Enum.filter(1..a, fn b -> {is_integer(:math.sqrt(a**2 + b**2))} end)
    Enum.map(1..a, fn b -> {a, b, :math.sqrt(a**2 + b**2)} end)
  end

end

# dictionary = %{"mama" => "mother", "papa" => "father"}
# original_string = "mama is with papa"
