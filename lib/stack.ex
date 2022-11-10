defmodule Stack do
  @moduledoc """
  Documentation for `Stack`
  """
  use GenServer

  @doc """
  Start the `Stack` process.

  ## Examples

    iex> {:ok, pid} = Stack.start_link([])
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @doc """
  Synchronously push an element onto the top of the `Stack`. Return the current stack.

  ## Examples

      iex> {:ok, pid} = Stack.start_link([])
      iex> Stack.push(pid, 1)
      [1]
      iex> Stack.push(pid, 2)
      [2, 1]
      iex> Stack.push(pid, 3)
      [3, 2, 1]
  """
  def push(pid, element) do
    GenServer.call(pid, {:push, element})
  end

  @doc """
  Pop an element from the top of the `Stack`.

  ## Examples

      iex> {:ok, pid} = Stack.start_link([])
      iex> Stack.push(pid, 1)
      iex> Stack.push(pid, 2)
      iex> Stack.push(pid, 3)
      iex> Stack.pop()
      3
      iex> Stack.pop()
      2
      iex> Stack.pop()
      1
  """
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:push, element}, _from, state) do
    {:reply, [element | state], state}
  end

  @impl true
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    [response | _tail] = state
    {:reply, response, state}
  end
end
