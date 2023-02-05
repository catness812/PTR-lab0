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

end
