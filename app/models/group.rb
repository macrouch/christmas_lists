class Group < ActiveRecord::Base
  belongs_to :user
  has_many :collections
  has_many :group_members
  has_many :members, through: :group_members, source: :user
  has_many :sub_groups
  has_many :sub_group_members, through: :sub_groups, source: :members

  validates :name, presence: true
  validates :question, presence: true
  validates :answer, presence: true
  validates :user_id, presence: true

  obfuscate_id spin: 48151248

  def non_sub_group_members
    members.select { |member| !sub_group_members.include? member }
  end

  def draw_names
    collection = collections.first
    collection.name_drawings.destroy_all
    available_members = sub_group_members.map(&:id)

    sub_group_members.each do |member|
      # temporarily remove members other sub_group_members
      sub_group = sub_groups.select { |g| g.members.include?(member) }
      same_sub_group_members = sub_group.first.members.map(&:id)

      temp_available_members = available_members - same_sub_group_members

      # select random available member
      receiver = temp_available_members[rand(temp_available_members.size)]

      # remove selected member from available_members
      available_members -= [receiver]

      name_drawing = NameDrawing.new
      name_drawing.picker = member
      name_drawing.receiver_id = receiver
      name_drawing.collection = collection
      name_drawing.save
    end
  end
end
