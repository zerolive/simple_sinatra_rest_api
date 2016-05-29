class Widgets

  @widgets = [{ :id => 1, :name => "First Widget"}, { :id => 2, :name => "Second Widget"}]

  class << self

    def all
      @widgets
    end

    def find_one id
      match = {}
      @widgets.each do |widget|
        match = widget if widget[:id].eql?(id.to_i)
      end
      match
    end

    def add new_name
      @widgets << { :id => new_id, :name => new_name }
      @widgets.last
    end

    def update_one id, new_name
      widget = find_one(id)
      return widget if widget.empty?
      widget[:name] = new_name
      widget
    end

    def delete id
      widget = find_one(id)
      @widgets.delete(widget)
      widget
    end

    def reset
      @widgets = default_data
    end

    private

    def new_id
      @widgets.last[:id] + 1
    end

    def default_data
      [{ :id => 1, :name => "First Widget"}, { :id => 2, :name => "Second Widget"}]
    end

  end
end