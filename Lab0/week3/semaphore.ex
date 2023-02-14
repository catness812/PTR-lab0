defmodule Semaphore do
  use GenServer

  def create(count \\ 1) do
    {:ok, pid} = GenServer.start_link(Semaphore, count)
    pid
  end

  def acquire(pid), do: GenServer.call(pid, :acquire)
  def release(pid), do: GenServer.call(pid, :release)

  def init(count), do: {:ok, %{count: count, initial_count: count}}

  def handle_call(:acquire, _from, state = %{count: 0}) do
    {:reply, {:error, state}, state}
  end

  def handle_call(:acquire, _from, state = %{count: count}) do
    {:reply, {:ok, %{state | count: count - 1}}, %{state | count: count - 1}}
  end

  def handle_call(:release, _from, state = %{count: count, initial_count: initial_count}) when count >= initial_count do
    {:reply, {:error, state}, state}
  end

  def handle_call(:release, _from, state = %{count: count}) do
    {:reply, {:ok, %{state | count: count + 1}}, %{state | count: count + 1}}
  end

end
