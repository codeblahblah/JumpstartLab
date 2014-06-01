require 'yaml/store'
require 'date'
require_relative './idea'

class IdeaStore
  SLOTS = [0, 4, 8, 12, 16, 20]

  def self.database
    return @database if @database

    @database = YAML::Store.new('db/ideabox')
    @database.transaction do
      @database['ideas'] ||= []
    end
    @database
  end

  def self.create(data)
    database.transaction do
      database['ideas'] << data
    end
  end

  def self.all
    ideas = []
    raw_ideas.each_with_index do |data, i|
      ideas  << Idea.new(data.merge("id" => i))
    end
    ideas
  end

  def self.find_by_day(day)
    all.select { |idea| DateTime.parse(idea.created_at).wday + 1 == day }
  end

  def self.find_by_time_slot(id)
    slot_start = SLOTS[id]
    slot_end = SLOTS[id] + 3
    all.select { |idea| DateTime.parse(idea.created_at).hour.between?(slot_start, slot_end) }
  end

  def self.find_by_tag(tag)
    all.select { |idea| idea.tags.include?(tag) }
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
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
    Idea.new(raw_idea.merge("id" => id))
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end
end
