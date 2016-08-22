require 'chronic'
require 'colorize'
require "test/unit"
require 'date'
require_relative "../lib/listable"
require_relative "../lib/errors"
require_relative "../lib/udacilist"
require_relative "../lib/todo"
require_relative "../lib/event"
require_relative "../lib/link"

class UdaciListTest < Test::Unit::TestCase

  def setup
    @list = UdaciList.new(title: "Julia's Stuff")
    @list.add("todo", "Buy more cat food", due: "2016-02-03", priority: "low")
    @list.add("todo", "Sweep floors", due: "2016-01-30")
    @list.add("todo", "Buy groceries", priority: "high")
    @list.add("event", "Birthday Party", start_date: "2016-05-08")
    @list.add("event", "Vacation", start_date: "2016-05-28", end_date: "2016-05-31")
    @list.add("link", "https://github.com", site_name: "GitHub Homepage")
  end

  def test_add_should_insert_todo_in_the_list
    assert_equal(6, @list.all.size)
  end

  def test_add_invalid_type_should_throws_an_error
    assert_raise(UdaciListErrors::InvalidItemType.new("image is not a valid type")) {
      @list.add("image", "http://ruby-doc.org")
    }
  end

  def test_add_invalid_priority_should_throws_an_error
    assert_raise(UdaciListErrors::InvalidPriorityValue.new("super high is not a valid priority")) {
      @list.add("todo", "Hack some portals", priority: "super high")
    }
  end

  def test_filter_by_type
    assert_equal(3, @list.filter("todo").size)
    assert_equal(2, @list.filter("event").size)
    assert_equal(1, @list.filter("link").size)
  end

  def test_delete_should_remove_by_todo_list_number
    @list.delete(3)
    assert_equal(5, @list.all.size)
    assert_equal(2, @list.filter("todo").size)
  end

  def test_delete_greater_than_list_size_should_throws_an_error
    assert_raise(UdaciListErrors::IndexExceedsListSize.new("list is 1 based and contains 6 records")) {
      @list.delete(9)
    }
  end

  def test_delete_lesser_than_list_index_should_throws_an_error
    assert_raise(UdaciListErrors::IndexExceedsListSize.new("list is 1 based and contains 6 records")) {
      @list.delete(0)
    }
  end

  def test_delete_bounds_test
    @list.delete(6)
    @list.delete(1)
    assert_equal(4, @list.all.size)
  end

end
