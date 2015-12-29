require_relative 'rule'
require_relative 'conditions'

module ZendeskAPI
  class View < Rule
    include Conditions

    self.resource_name = 'views'
    self.singular_resource_name = 'view'

    #has_many :tickets, :class => Ticket
    #has_many :feed, :class => Ticket, :path => "feed"

    #has_many :rows, :class => ViewRow, :path => "execute"
    #has :execution, :class => RuleExecution
    #has ViewCount, :path => "count"

    def add_column(column)
      columns = execution.columns.map(&:id)
      columns << column
      self.columns = columns
    end

    def columns=(columns)
      self.output ||= {}
      self.output[:columns] = columns
    end

    def self.preview(client, options = {})
      Collection.new(client, ViewRow, options.merge(:path => "views/preview", :verb => :post))
    end
  end
end