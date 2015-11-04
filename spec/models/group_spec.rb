require 'rails_helper'

describe Group do
  it { should belong_to :user }
  it { should have_many :collections }
  it { should have_many :group_members }
  it { should have_many(:members).through(:group_members) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :question }
  it { should validate_presence_of :answer }
  it { should validate_presence_of :user_id }

  # TODO create test for draw_names method
  it 'draws names that are exclusive of sub_groups' do
    # create a lot of members
    20.times do |index|
      User.create(
        name: "User #{index}",
        uid: "user_#{index}",
        provider: 'identity',
        email: "user_#{index}@example.com",
        active: true
      )
    end

    # create collection, group
    group = Group.create(
      name: 'test group',
      question: 'question',
      answer: 'answer',
      user: User.first
    )

    collection = Collection.create(
      name: 2015,
      group: group
    )

    # add members to group
    User.all.each do |user|
      user.groups << group
    end

    # add members to sub_groups
    5.times do |index|
      start = index * 3
      stop = start + 2

      sub_group = group.sub_groups.create
      User.all[start..stop].each do |user|
        sub_group.members << user
      end
    end

    # draw names
    group.draw_names

    # assert name_drawings aren't in same sub_groups
    collection.name_drawings.each do |name_drawing|
      other_members = group.sub_groups.select { |g| g.members.include?(name_drawing.picker) }
      expect(other_members).to_not include(name_drawing.receiver)
    end

    # assert non_sub_group_members aren't in any name_drawings
    group.non_sub_group_members.each do |member|
      expect(collection.name_drawings.where(picker_id: member.id).size).to eq(0)
      expect(collection.name_drawings.where(receiver_id: member.id).size).to eq(0)
    end
  end
end
