module Pokrovsky
  describe Historiograph do
    before :each do
      Timecop.freeze Time.local 1970, 01, 01
      @json = '{
        "id": "arbitrary",
        "data": [
          [1, 0],
          [0, 0],
          [1, 0],
          [0, 0],
          [0, 0],
          [0, 0],
          [0, 0]
          ]
        }'
      @h    = Historiograph.new @json
    end

    it 'should contain days' do
      @h[0].class.should == Pokrovsky::Day
    end

    it 'should start on Sunday 27 weeks ago' do
      @h[0].date.should == '1969-06-29'
    end

    it 'should have length 2' do
      @h.length.should == 2
    end

    describe 'more realistic situation' do
      before :each do
        Timecop.freeze Time.local 1974, 06, 15
        @json = '{
          "id": "1982",
          "data": [
            [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
            [0,0,0,1,1,0,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0],
            [0,0,1,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,1,0],
            [0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,1,0],
            [0,0,0,0,1,0,0,0,0,0,1,1,1,1,1,0,0,1,0,0,0,0,1,0,0,0,1,1,1,1,0,0],
            [0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,0],
            [0,0,1,1,1,1,1,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,1,1,1,1,1,0]
          ]
        }'
        @h = Historiograph.new @json
      end

      it 'should have length 66' do
        @h.length.should == 66
      end

      it 'should have its first commit on the 13th Monday past 1 year ago' do
        @h[0].date.should == '1973-09-11'
      end

      it 'should have its last commit on the 41st Saturday past 1 year ago' do
        @h[65].date.should == '1974-03-30'
      end
    end
  end
end