defmodule W3 do

  def print do
    receive do
      msg ->
        IO.puts(msg)
    end
    print()
  end
  # pid = spawn(W3, :print, [])
  # send(pid, "hi")
  # send(pid, "how are you")

  def modify do
    receive do
      msg ->
        cond do
          is_integer(msg) ->
            msg1 = msg + 1
            IO.puts("Recieved: #{msg}")
            IO.puts("Modified: #{msg1}\n")
          is_binary(msg) ->
            msg1 = String.downcase(msg)
            IO.puts("Recieved: #{msg}")
            IO.puts("Modified: #{msg1}\n")
          msg ->
            IO.puts("I don't know how to HANDLE this!\n")
        end
    end
    modify()
  end
  # pid = spawn(W3, :modify, [])
  # send(pid, 10)
  # send(pid, "Hello")
  # send(pid, {10, "Hello"})

  def actor, do: exit(:bye)
  def actorMonitor do
    spawn_monitor(W3, :actor, [])
    receive do
      {:DOWN, _ref, :process, _pid, reason} ->
        IO.puts("Actor stopped\nReason: #{reason}")
    end
  end
  # W3.actorMonitor

  def averager(sum, n) do
    receive do
      nr ->
        sum1 = sum + nr
        k = n + 1
        avg = sum1 / k
        IO.puts("Current average is #{avg}")
        averager(sum1, k)
    end
  end
  # pid = spawn(W3, :averager, [0,0])
  # send(pid, 0)
  # send(pid, 10)

end
