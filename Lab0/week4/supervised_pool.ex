defmodule Worker do
  def start_link do
    pid = spawn_link(__MODULE__, :loop, [[]])
    {:ok, pid}
  end

  def echo(pid, msg) do
    send(pid, {:echo, self(), msg})
    receive do
      {:echo, msg} -> msg
    end
  end

  def loop(state) do
    receive do
      {:echo, from, msg} ->
        send(from, {:echo, msg})
        loop(state)
    end
  end
end

defmodule PoolSupervisor do
  use Supervisor

  def create(workers) do
    {:ok, supervisor} = Supervisor.start_link(__MODULE__, workers, name: __MODULE__)
    supervisor
  end

  def init(workers) do
    children = Enum.map(1..workers, fn i ->
      %{
        id: i,
        start: {Worker, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker
      }
    end)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker(id) do
    child = Supervisor.which_children(__MODULE__)
    elem(Enum.find(child, fn {worker_id, _pid, _type, _module} -> worker_id == id end), 1)
  end

  def kill_worker(id) do
    pid = get_worker(id)
    send(pid, :kill)
    IO.puts("Worker #{id} has been killed and restarted.")
  end

  def display_workers do
    Enum.reverse(Supervisor.which_children(__MODULE__))
  end
end
