require 'rails_helper'
#test things yeah idk
RSpec.describe Cases, :type => :model do
  describe ".class#check_for_new_data" do

    it "gets creates new entry if table is empty" do

      expect(Cases.check_for_new_data).to eq(true)
      expect(Cases.all.length).to eq(1)
    end
    describe "creates new case if" do

      it "last entry was yesterday and time.now is past 11am" do
        Cases.create({total: 12, active: 10, deaths: 5})
        now = Time.parse("2020-07-31 11:59:00 -0400")
        allow(Time).to receive(:now) { now }

        expect(Cases.check_for_new_data).to eq(true)
      end

      it "total is unchanged and its past 3pm" do
        Cases.create(CaseScraper.get_new_data)

        now = Time.parse("2020-07-31 15:05:00 -0400")
        allow(Time).to receive(:now) { now }

        expect(Cases.check_for_new_data).to eq(true)
      end

      it "added the case to db with correct data" do
        # expect(Cases.last.total.class).to eq(Integer)
      end

    end
    describe "will not create new case if" do
      it "is not past 11am" do
        Cases.create({total: 12, active: 10, deaths: 5})

        now = Time.parse("2020-07-31 8:05:00 -0400")
        allow(Time).to receive(:now) { now }

        expect(Cases.check_for_new_data).to eq(false)
      end


    end
  end
end
