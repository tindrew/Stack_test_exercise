defmodule StackTest do
  use ExUnit.Case

  describe "start_link/1" do
    test "with no configuration" do
     assert {:ok, pid} = Stack.start_link([])
    end
    test "with a default state" do
      assert {:ok, pid} = Stack.start_link([name: "whatever"])
      assert :sys.get_state(pid) == [name: "whatever"]
    end
  end

  describe "push/2" do
    test "an element onto an empty stack" do
      assert {:ok, pid} = Stack.start_link([])
      assert Stack.push(pid, "whatever") == ["whatever"]
    end
    test "an element onto a stack with one element" do
      assert {:ok, pid} = Stack.start_link(["whatever"])
      assert Stack.push(pid, "something else") == ["something else", "whatever"]
    end
    test "an element onto a stack with multiple elements" do
      assert {:ok, pid} = Stack.start_link(["something else", "whatever"])
      assert Stack.push(pid, "George") == ["George", "something else", "whatever"]
    end
  end

  describe "pop/1" do
    test "an empty stack" do
      assert {:ok, pid} = Stack.start_link([])
      assert Stack.pop(pid) == nil
    end
    test "a stack with one element" do
       assert {:ok, pid} = Stack.start_link(["Whatever"])
       assert Stack.pop(pid) == "Whatever"
    end
    test "a stack with multiple elements" do
      assert {:ok, pid} = Stack.start_link(["George", "something else", "Whatever"])
       assert Stack.pop(pid) == "George"
    end
  end
end
