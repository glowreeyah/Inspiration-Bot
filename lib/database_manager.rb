module DatabaseManager
  DATA_LOCATION = './db/'.freeze

  def append_to_file(file_name, entry)
    n = File.new("#{DATA_LOCATION}#{file_name}.txt", 'a')
    n.write("#{entry}\n")
    n.close
    'Appended to File'
  end

  def file_exists?(file_name)
    File.file?("#{DATA_LOCATION}#{file_name}.txt")
  end

  def file_to_arr(file_name)
    return unless file_exists?(file_name)

    File.read("#{DATA_LOCATION}#{file_name}.txt").split("\n")
  end

  def overwrite_file(file_name, new_arr)
    n = File.new("#{DATA_LOCATION}#{file_name}.txt", 'w')
    new_arr.each do |item|
      n.write("#{item}\n")
    end
    n.close
    'File Overwritten'
  end

  def contain_in_file?(file_name, entry)
    return unless file_exists?(file_name)

    file_to_arr(file_name).include?(entry.to_s) ? true : false
  end

  def remove_from_file(file_name, entry)
    if contain_in_file?(file_name, entry)
      temp_arr = file_to_arr(file_name)
      temp_arr.delete(entry.to_s)
      overwrite_file(file_name, temp_arr)
      'File Removed'
    else
      'Entry Not Found'
    end
  end
end
