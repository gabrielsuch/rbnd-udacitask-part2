module Listable
  attr_reader :description

  def format_description
    "#{UdaciList::type_class.key(self.class)}: #{@description}".ljust(35)
  end

  def format_dates
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates
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
end
