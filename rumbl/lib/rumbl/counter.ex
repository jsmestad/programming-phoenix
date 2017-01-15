defmodule Rumbl.Counter do
  use GenServer

  # def inc(pid), do: send(pid, :inc)
  def inc(pid), do: GenServer.cast(pid, :inc)

  # def dec(pid), do: send(pid, :dec)
  def dec(pid), do: GenServer.cast(pid, :dec)

  # def val(pid, timeout \\ 5000) do
    # ref = make_ref()
    # send(pid, {:val, self(), ref})
    # receive do
      # {^ref, val} -> val
    # after timeout -> exit(:timeout)
    # end
  # end
  def val(pid) do
    GenServer.call(pid, :val)
  end

  # def start_link(initial_val) do
    # {:ok, spawn_link(fn -> listen(initial_val) end)}
  # end
  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val)
  end

  # defp listen(val) do
    # receive do
      # :inc -> listen(val + 1)
      # :dec -> listen(val - 1)
      # {:val, sender, ref} ->
        # send sender, {ref, val}
        # listen(val)
    # end
  # end

  def init(initial_val) do
    {:ok, initial_val}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end
