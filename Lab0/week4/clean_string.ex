defmodule CleanSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      %{
        id: SplitWorker,
        start: {SplitWorker, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker
      },
      %{
        id: TransformWorker,
        start: {TransformWorker, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker
      },
      %{
        id: JoinWorker,
        start: {JoinWorker, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def clean(string) do
    string
    |> SplitWorker.clean()
    |> TransformWorker.clean()
    |> JoinWorker.clean()
  end

  def get_worker(id) do
    child = Supervisor.which_children(__MODULE__)
    elem(Enum.find(child, fn {worker_id, _pid, _type, _module} -> worker_id == id end), 1)
  end

  def display_workers do
    Enum.reverse(Supervisor.which_children(__MODULE__))
  end
end

defmodule SplitWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def clean(string) do
    GenServer.call(__MODULE__, {:clean, string})
  end

  def handle_call({:clean, string}, _from, state) do
    cleaned = string |> String.split()
    {:reply, cleaned, state}
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info(:kill, state) do
    {:stop, :restart, state}
  end
end

defmodule TransformWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def clean(strings) do
    GenServer.call(__MODULE__, {:clean, strings})
  end

  def handle_call({:clean, strings}, _from, state) do
    cleaned = strings
    |> Enum.map(&String.downcase/1)
    |> Enum.map(&String.replace(&1, ~r/[mn]/i, fn
      "n" -> "m"
      "m" -> "n"
      c -> c
    end))
    {:reply, cleaned, state}
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info(:kill, state) do
    {:stop, :restart, state}
  end
end

defmodule JoinWorker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def clean(strings) do
    GenServer.call(__MODULE__, {:clean, strings})
  end

  def handle_call({:clean, strings}, _from, state) do
    cleaned = strings |> Enum.join(" ")
    {:reply, cleaned, state}
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info(:kill, state) do
    {:stop, :restart, state}
  end
end
