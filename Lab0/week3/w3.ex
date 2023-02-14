defmodule W3 do

  def print, do: spawn(W3, :print_loop, [])
  def print_loop do
    receive do
      msg ->
        IO.puts(msg)
    end
    print_loop()
  end


  def modify, do: spawn(W3, :modify_loop, [])
  def modify_loop do
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
    modify_loop()
  end


  def actorMonitor do
    spawn_monitor(W3, :actor, [])
    receive do
      {:DOWN, _ref, :process, _pid, reason} ->
        IO.puts("Actor stopped\nReason: #{reason}")
    end
  end
  def actor do
    receive do
      after 3000 ->
        exit(:bye)
    end
  end


  def averager, do: spawn(W3, :averager_loop, [0,0])
  def averager_loop(sum, n) do
    receive do
      nr ->
        sum1 = sum + nr
        k = n + 1
        avg = sum1 / k
        IO.puts("Current average is #{avg}")
        averager_loop(sum1, k)
    end
  end


  use GenServer
  def new_queue do
    {:ok, pid} = GenServer.start_link(W3, [])
    pid
  end
  def queue(pid), do: GenServer.call(pid, :state)
  def push(pid, element), do: GenServer.call(pid, {:push, element})
  def pop(pid), do: GenServer.call(pid, :pop)

  def init(new_queue), do: {:ok, new_queue}
  def handle_call(:state, _from, state), do: {:reply, Enum.reverse(state), state}
  def handle_call({:push, element}, _from, state), do: {:reply, :ok, state ++ [element]}
  def handle_call(:pop, _from, [hd | tl]), do: {:reply, hd, tl}
  def handle_call(:pop, _from, []), do: {:reply, {:error, "No elements in the queue!"}, []}

end
