require 'spec_helper'

describe Address do
  context 'fields' do
    it { should have_fields(:country, :state, :sity, :street) }
  end

  context 'association' do
    it { should be_embedded_in :hotel }
  end

  context 'validates' do
    it { should validate_presence_of :country }
    it { should validate_presence_of :state }
    it { should validate_presence_of :sity }
    it { should validate_presence_of :street }
  end
end
