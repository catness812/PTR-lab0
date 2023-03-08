defmodule DLL do
  def create([hd | tl]) do
    pid = spawn(DLL, :loop, [hd, nil, nil])
    append(pid, tl)
    pid
  end

  def loop(el, prev, next) do
    receive do
      {:append, [hd | tl]} ->
        pid = spawn(DLL, :loop, [hd, self(), nil])
        append(pid, tl)
        loop(el, prev, pid)

      {:traverse, pid, list} ->
        case next do
          nil ->
            send(pid, {:ok, list ++ [{el, self()}]})

          _ ->
            send(next, {:traverse, pid, list ++ [{el, self()}]})
        end
        loop(el, prev, next)

      {:inverse, pid, list} ->
        case next do
          nil ->
            send(pid, {:ok, [{el, self()}] ++ list})

          _ ->
            send(next, {:inverse, pid, [{el, self()}] ++ list})
        end
        loop(el, prev, next)
    end
  end

  def traverse(pid) do
    send(pid, {:traverse, self(), []})

    receive do
      {:ok, list} ->
        Enum.map(list, &{el_pid(&1), el_value(&1)})
    end
  end

  def inverse(pid) do
    send(pid, {:inverse, self(), []})

    receive do
      {:ok, list} ->
        Enum.map(list, &{el_pid(&1), el_value(&1)})
    end
  end

  defp append(pid, tl), do: send(pid, {:append, tl})
  defp el_pid({_el, pid}), do: pid
  defp el_value({el, _pid}), do: el
end
