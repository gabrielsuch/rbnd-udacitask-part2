class UdaciList
  attr_reader :title, :items

  @@valid_types = [ "todo", "event", "link" ]

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemType.new("#{type} is not a valid type") unless @@valid_types.include? type
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(*indexes)
    items_to_delete = []

    indexes.each do |index|
      raise UdaciListErrors::IndexExceedsListSize.new("list contains #{items.size} records") if index >= @items.size
      items_to_delete << @items.at(index - 1)
    end

    items_to_delete.each do |each|
      @items.delete(each)
    end
  end

  def all
    display_title @title || 'Untitled List'
    display_items @items
  end

  def filter(item_type)
    type_class = { todo: TodoItem, event: EventItem, link: LinkItem }
    items_type = @items.select { |item| item.class == type_class[item_type.to_sym] }

    display_title "Items with type: #{item_type}"
    display_items items_type
  end

  def display_title(title)
    puts "-" * title.length
    puts title
    puts "-" * title.length
  end

  def display_items(items)
    items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

end
