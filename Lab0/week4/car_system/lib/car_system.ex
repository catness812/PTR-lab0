defmodule CarSystem do
  use Application
  require Logger

  def start(_args, _type) do
    Logger.info("Starting System")
    SensorSupervisor.start_link()
  end

  def prep_stop(_state) do
    Logger.notice("Deploying Airbags")
  end
end

defmodule SensorSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = [
      %{
        id: CabinSensor,
        start: {CabinSensor, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker,
        max_restarts: 3,
        max_seconds: 60
      },
      %{
        id: MotorSensor,
        start: {MotorSensor, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker,
        max_restarts: 3,
        max_seconds: 60
      },
      %{
        id: ChassisSensor,
        start: {ChassisSensor, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :worker,
        max_restarts: 3,
        max_seconds: 60
      },
      %{
        id: WheelsSensorSupervisor,
        start: {WheelsSensorSupervisor, :start_link, []},
        restart: :transient,
        shutdown: 5000,
        type: :supervisor,
        max_restarts: 3,
        max_seconds: 60
      }
    ]

    Supervisor.init(children, strategy: :one_for_one, shutdown: {:bye})
  end

  def display_sensors do
    Enum.reverse(Supervisor.which_children(__MODULE__))
  end

  def get_sensor(id) do
    child = Supervisor.which_children(__MODULE__)
    elem(Enum.find(child, fn {sensor_id, _pid, _type, _module} -> sensor_id == id end), 1)
  end
end

defmodule WheelsSensorSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    children = Enum.map(1..4, fn i ->
      %{
        id: i,
        start: {WheelSensor, :start_link, ["wheel #{i}"]},
        restart: :transient,
        shutdown: 5000,
        type: :worker,
        max_restarts: 3,
        max_seconds: 60
      }
    end)

    Supervisor.init(children, strategy: :one_for_one)
  end

  def display_sensors do
    Enum.reverse(Supervisor.which_children(__MODULE__))
  end

  def get_sensor(id) do
    child = Supervisor.which_children(__MODULE__)
    elem(Enum.find(child, fn {sensor_id, _pid, _type, _module} -> sensor_id == id end), 1)
  end
end

defmodule WheelSensor do
  use GenServer

  def start_link(wheel_name) do
    GenServer.start_link(__MODULE__, wheel_name)
  end

  def init(wheel_name) do
    IO.puts("Starting #{wheel_name} sensor.")
    {:ok, wheel_name}
  end

  def handle_info(:crash, state) do
    IO.puts("Invalid measurement detected, crashing sensor.")
    Process.exit(self(), :crash)
    {:noreply, state}
  end
end

defmodule CabinSensor do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    IO.puts("Starting cabin sensor.")
    {:ok, state}
  end

  def handle_info(:crash, state) do
    IO.puts("Invalid measurement detected, crashing sensor.")
    Process.exit(self(), :crash)
    {:noreply, state}
  end
end

defmodule MotorSensor do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    IO.puts("Starting motor sensor.")
    {:ok, state}
  end

  def handle_info(:crash, state) do
    IO.puts("Invalid measurement detected, crashing sensor.")
    Process.exit(self(), :crash)
    {:noreply, state}
  end
end

defmodule ChassisSensor do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    IO.puts("Starting chassis sensor.")
    {:ok, state}
  end

  def handle_info(:crash, state) do
    IO.puts("Invalid measurement detected, crashing sensor.")
    Process.exit(self(), :crash)
    {:noreply, state}
  end
end
