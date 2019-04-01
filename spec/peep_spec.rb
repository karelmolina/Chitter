require 'peep'
require 'database_helper'

describe Peep do
  describe '#create' do
    it 'create a new peep' do
      peep = Peep.create(content: 'This is the 1st test peep')
      expect(peep).to be_a Peep
      p_data = persisted_data(id: peep.id, table: 'peeps')

      expect(peep.content).to eq 'This is the 1st test peep'
      expect(peep.id).to eq p_data.first["id"]
    end

  end

  describe '#show' do
    it 'show all peeps' do
      peep = Peep.create(content: 'this is the 2nd peep')
      Peep.create(content: 'this is the 3th peep')
      peeps = Peep.show
      expect(peeps.length).to eq 2
      expect(peeps.first).to be_a Peep
      expect(peep.first.content).to eq'this is the 2nd peep'

    end
  end
end
