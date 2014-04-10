require 'spec_helper'

describe Hotel do
  context 'fields' do
    it { should have_fields(:title, :star_rating, :breakfast_included,
                            :room_description, :photo, :price_for_room) }
    it { should be_timestamped_document }
  end

  context 'association' do
    it { should embed_one  :address }
    it { should embed_many :comments }
    it { should belong_to  :user }
  end

  context 'nested attributes' do
    it { should accept_nested_attributes_for :address }
  end

  context 'validates' do
    it { should validate_presence_of :title }
    it { should validate_numericality_of :star_rating }
    it { should validate_presence_of :price_for_room }
    it { should validate_numericality_of :price_for_room }
  end

  context 'delegate' do
    let(:address) { build_stubbed :address }
    let(:hotel) { address.hotel }

    it { expect(hotel.country).to eql address.country }
    it { expect(hotel.state).to eql address.state }
    it { expect(hotel.sity).to eql address.sity }
    it { expect(hotel.street).to eql address.street }
  end

  context '.top' do
    context 'return typed size' do
      let(:count) { 1 }
      before { create_list(:hotel_without_user, 2) }

      it { expect(described_class.top(count).to_a.size).to eql count }
    end

    context 'sort hotels by rating (DESC)' do
      let(:count) { 2 }
      let!(:hotels) { create_list(:top, count) }

      it { expect(described_class.top(count).first).to eql hotels.last }
    end
  end
end
