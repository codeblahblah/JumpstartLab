class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id, :created_at, :updated_at, :tags

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
    @rank = attributes["rank"] || 0
    @id = attributes["id"]
    @created_at = Time.now.to_s
    @tags = prepare_tags(attributes["tags"])
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank,
      "created_at" => created_at, 
      "tags" => tags
    }
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end

  def prepare_tags(tags)
    "App store unique ideas".downcase.split
  end
end
