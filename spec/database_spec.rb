require_relative '../lib/database_manager'

RSpec.describe DatabaseManager do
  include DatabaseManager
  let(:file_test1) { 'state_tests' }
  let(:file_test2) { 'file_testing' }
  let(:file_test3) { 'No File' }
  let(:test_id1) { 1_061_110_010 }
  let(:test_id2) { 'Entry Not Found' }

  describe '#contain_in_file?' do
    it 'returns true if entry is in the file' do
      expect(contain_in_file?(file_test1, test_id1)).to be true
    end
    it 'returns false if entry is not in the file' do
      expect(contain_in_file?(file_test1, test_id2)).not_to be true
    end
  end

  describe '#append_to_file' do
    it 'checks if appended line exists before the contain_in_file method' do
      expect(contain_in_file?(file_test2, 'appended line')).not_to be true
    end
    it 'appends line to file and returns confirmation if there is no error' do
      expect(append_to_file(file_test2, 'appended line')).to eq('Appended to File')
    end
    it 'checks the output from above with contain in file method' do
      expect(contain_in_file?(file_test2, 'appended line')).to be true
    end
  end

  describe '#file_exists?' do
    it 'returns true if file exists' do
      expect(file_exists?(file_test1)).to be true
    end
    it 'returns false if file does not exist' do
      expect(file_exists?(file_test3)).not_to be true
    end
  end

  describe 'overwrite_file' do
    it 'checks to ensure test_id2 before testing if it is contained in file' do
      expect(contain_in_file?(file_test2, 'test id2')).not_to be true
    end
    it 'overwrites file with a new array and returns no error' do
      expect(overwrite_file(file_test2, ['test id2'])).to eq('File Overwritten')
    end
    it 'checks the file output from above with contain_in_file? method' do
      expect(contain_in_file?(file_test2, 'test id2')).to be true
    end
  end

  describe 'remove_from_file' do
    it 'checks to ensure test id2 exists with the contain_in_file method before removing' do
      expect(contain_in_file?(file_test2, 'test id2')).not_to be false
    end
    it 'removes entry and returns no errors' do
      expect(remove_from_file(file_test2, 'test id2')).to eq('File Removed')
    end
    it 'checks if the removed entry is in the file' do
      expect(contain_in_file?(file_test2, test_id2)).to be false
    end
    it 'returns not found when the entry is not in the file' do
      expect(remove_from_file(file_test3, 'text id2')).to eq('Entry Not Found')
    end
  end
end
