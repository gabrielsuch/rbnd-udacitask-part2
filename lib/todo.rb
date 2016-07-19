class TodoItem
  include Listable
  attr_reader :due, :priority

  @@valid_priorities = ["low", "medium", "high", nil]

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    priority(options[:priority])
  end

  def priority(priority)
    if !@@valid_priorities.include? priority
      raise UdaciListErrors::InvalidPriorityValue.new("#{priority} is not a valid priority")
    end

    @priority = priority
  end

  def format_date
    @due ? @due.strftime("%D") : "No due date"
  end

  def format_priority
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:blue) if @priority == "medium"
    value = " ⇩".colorize(:white) if @priority == "low"
    value = "" if !@priority
    return value
  end

  def details
    format_description + "due: " +
    format_date +
    format_priority
  end

end
