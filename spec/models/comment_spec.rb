require 'spec_helper'

describe Comment do
  context 'fields' do
    it { should have_fields :text }
    it { should be_timestamped_document }
  end

  context 'association' do
    it { should be_embedded_in :hotel }
    it { should belong_to :user }
  end

  context 'validates' do
    it { should validate_presence_of :text }
  end
end
