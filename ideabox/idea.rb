require 'yaml/store'

class Idea
  attr_reader :title, :description

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @rank = attributes["rank"] || 0
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank
    }
  end

  def self.all
    raw_ideas.map do |data|
      new(data)
    end
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.database
    @database ||= YAML::Store.new('ideabox')
  end

  def database
    Idea.database
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    new(raw_idea)
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end
end
