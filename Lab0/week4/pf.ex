defmodule Jules do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def ask() do
    GenServer.call(__MODULE__, :ask)
  end

  def init(_) do
    state = %{
      questions: [
        "What does Marcellus Wallace look like?",
        "What country you from?!",
        "What ain't no country I've ever heard of! They speak English in What?",
        "English motherfucker do you speak it!?",
        "Describe what Marcellus Wallace looks like.",
        "Does he look like a bitch?",
      ],
      warning: "Say what again. SAY WHAT again! And I dare you, I double dare you motherfucker! Say what one more time.",
      what: 0
    }
    {:ok, state}
  end

  def handle_call(:ask, _from, state) do
    Process.sleep(1000)

    question = Enum.random(state[:questions])
    IO.puts("Jules: #{question}")

    answer = Brett.answer()

    if (answer == "What?") do
      state = %{state | what: state[:what] + 1}

      case state[:what] do
        3 ->
          Process.sleep(500)
          IO.puts("BANG!")
          Brett.kill()
        2 ->
          Process.sleep(500)
          IO.puts("Jules: #{state[:warning]}")
        _ -> :ok
      end

      {:reply, question, state}
    else
      {:reply, question, state}
    end
  end
end

defmodule Brett do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def answer() do
    GenServer.call(__MODULE__, :answer)
  end

  def kill() do
    GenServer.cast(__MODULE__, :kill)
  end

  def init(_) do
    state = %{
      answers: [
        "Yes",
        "He's black",
        "He's bald",
      ]
    }
    {:ok, state}
  end

  def handle_call(:answer, _from, state) do
    Process.sleep(1000)

    if (:rand.uniform() > 0.6) do
      answer = Enum.random(state[:answers])
      IO.puts("Brett: #{answer}")
      {:reply, answer, state}
    else
      IO.puts("Brett: What?")
      {:reply, "What?" , state}
    end
  end

  def handle_cast(:kill, state) do
    IO.puts("Bye Brett")
    Process.exit(self(), :ok)
    {:noreply, state}
  end
end

defmodule PF do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [
      %{
        id: Jules,
        start: {Jules, :start_link, []},
        shutdown: 5000,
        type: :worker
      },
      %{
        id: Brett,
        start: {Brett, :start_link, []},
        shutdown: 5000,
        type: :worker
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def start do
    Jules.ask
    start()
  end
end
