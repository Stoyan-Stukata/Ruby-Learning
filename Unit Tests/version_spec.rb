require './version'

RSpec.describe Version do
  context 'The constructor' do
    it 'creates a Version object from valid data' do
      expect(Version.new('1.5')).not_to be nil
      expect(Version.new('0.0')).not_to be nil
      expect(Version.new('0.5')).not_to be nil
      expect(Version.new('1')).not_to be nil
    end

    it 'raises an error from invalid data' do
      expect { Version.new('a') }.to raise_error ArgumentError, "Invalid version string 'a'"
      expect { Version.new('a.1') }.to raise_error an_instance_of(ArgumentError), /Invalid version/
      expect { Version.new('1.a') }.to raise_error ArgumentError, "Invalid version string '1.a'"
    end
  end

  context 'The method <=>' do
    it 'indicates rightfully when one version is less than the other' do
      expect(Version.new('0.1') <=> Version.new('0.1.1')).to eq(-1)
      expect(Version.new('0.1') <=> Version.new('0.2')).to eq(-1)
      expect(Version.new('0') <=> Version.new('0.0.0.0.0.0.0.0.0.1')).to eq(-1)
    end

    it 'indicates rightfully when one version is bigger than the other' do
      expect(Version.new('0.1.1') <=> Version.new('0.1')).to eq 1
      expect(Version.new('0.2') <=> Version.new('0.1')).to eq 1
      expect(Version.new('0.0.0.0.0.0.0.0.0.1') <=> Version.new('0')).to eq 1
    end

    it 'indicates rightfully when both versions are equal' do
      expect(Version.new('0.1') <=> Version.new('0.1.000000000000')).to eq 0
      expect(Version.new('0.2') <=> Version.new('0.2.0')).to eq 0
      expect(Version.new('0.0') <=> Version.new('0')).to eq 0
    end
  end
end
