require 'rails_helper'

describe NameDrawing do
  it { should belong_to :collection }
  it { should belong_to(:picker).class_name('User') }
  it { should belong_to(:receiver).class_name('User') }
  it { should validate_presence_of :collection }
  it { should validate_presence_of :picker_id }
  it { should validate_presence_of :receiver_id }
end
