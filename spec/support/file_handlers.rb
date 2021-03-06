module Support
  module FileHandlers
    def expect_identical_file_streams(f1,f2)
      f1.rewind
      f2.rewind
      expect(f1.read).to eq(f2.read)
    end
    def file_stream(name)
      open( rspec_file(name), "rb" )
    end
    def count_files_in_zip(name)
      `zipinfo -t #{rspec_file(name)} | sed -e "/ files.*/s///"`.to_i
    end
    def list_files_in_zip(name)
      `zipinfo -1 #{rspec_file(name)}`.split
    end
    def output_file_from_zip(name,fname)
      # unzip treats [ ] specially, so requires escaping for '[' and ']' in filenames like '[Content_Types].xml'
      unzip_fname = fname
        .gsub('[', '\\\\\[')
        .gsub(']', '\\\\\]')
      `unzip -p #{rspec_file(name)} #{unzip_fname}`
    end
  end
end
