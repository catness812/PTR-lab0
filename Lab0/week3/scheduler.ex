defmodule Scheduler do

  def create, do: spawn_link(Scheduler, :loop, [])

  def loop do
    Process.flag(:trap_exit, true)
    receive do
      {:worker, task} ->
        spawn_random(task)

      {:EXIT, _pid, :normal} ->
        IO.puts("Task successful : Miau")

      {:EXIT, _pid, task} ->
        IO.puts("Task fail")
        spawn_random(task)
    end
    loop()
  end

  def execute(pid, task), do: send(pid, {:worker, task})
  defp spawn_random(task) do
    spawn_link(fn ->
      case Enum.random(0..1) do
        0 -> exit(task)
        1 -> exit(:normal)
        _ -> nil
      end
    end)
  end

end
