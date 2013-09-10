require 'spec_helper'

describe Yeah::Desktop do
  let(:klass) { Yeah::Desktop }
  let(:instance) { klass.new }

  it { klass.should be_instance_of Class }

  describe '::new' do

    it { instance.instance_variables.should include :@screen }

    describe '@screen' do
      subject(:screen) { instance.instance_variable_get(:@screen) }

      it { screen.should be_instance_of Rubygame::Screen }
      it { screen.size.should eq [320, 240] }
    end
  end

  describe '#game' do
    subject { instance.game }

    it { should eq nil }
  end

  describe '#game=' do
    subject { instance.method(:game=) }

    it_behaves_like 'writer', Yeah::Game.new
  end
end
