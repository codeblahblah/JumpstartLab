class Idea
  attr_reader :title, :description

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
  end

  def save
    database.transaction do
      database['ideas'] ||= []
      database['ideas'] << { "title" => title, "description" => description }
    end
  end
end
