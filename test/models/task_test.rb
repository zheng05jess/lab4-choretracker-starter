require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # Associations
  should have_many(:chores)
  should have_many(:children).through(:chores)

  # Validations
  should validate_presence_of(:name)

  should validate_numericality_of(:points)
    .only_integer
    .is_greater_than(0)

  # Scopes
  context "scopes" do
    setup do
      @task1 = Task.create!(name: "Dishes", points: 5, active: true)
      @task2 = Task.create!(name: "Clean Room", points: 10, active: true)
      @task3 = Task.create!(name: "Vacuum", points: 8, active: false)
    end

    should "order tasks alphabetically by name" do
      assert_equal ["Clean Room", "Dishes", "Vacuum"],
                   Task.alphabetical.pluck(:name)
    end

    should "return only active tasks" do
      assert_equal [@task1, @task2].sort_by(&:name),
                   Task.active.sort_by(&:name)
    end
  end
end
