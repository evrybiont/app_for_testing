require 'spec_helper'

describe Profile do
  context 'fields' do
    it { should have_fields(:first_name, :last_name) }
  end

  context 'association' do
    it { should be_embedded_in :user }
  end

  context 'validates' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  context '#full_name' do
    let(:profile)   { build :profile }
    let(:full_name) { profile.first_name + ' ' + profile.last_name }

    it { expect(profile.full_name).to eql full_name }
  end
end
