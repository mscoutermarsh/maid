Maid.rules do
  # **NOTE:** It's recommended you just use this as a template; if you run these rules on your machine without knowing
  # what they do, you might run into unwanted results!

  rule 'Linux ISOs, etc' do
    trash(dir('~/Downloads/*.iso'))
  end

  rule 'downloaded PDF books' do
    move(dir('~/Downloads/*.pdf'), '~/Dropbox')
  end

  rule 'Linux applications in Debian packages' do
    trash(dir('~/Downloads/*.deb'))
  end

  rule 'Mac OS X applications in disk images' do
    trash(dir('~/Downloads/*.dmg'))
  end

  rule 'Mac OS X applications in zip files' do
    found = dir('~/Downloads/*.zip').select { |path|
      zipfile_contents(path).any? { |c| c.match(/\.app$/) }
    }

    trash(found)
  end

  rule 'Trash downloads over a month old' do
    dir('~/Downloads/*').each do |path|
      if 4.weeks.since?(accessed_at(path))
        trash(path)
      end
    end
  end


  rule 'Misc Screenshots' do
    dir('~/Desktop/Screen shot *').each do |path|
      if 1.week.since?(accessed_at(path))
        move(path, '~/Documents/Misc Screenshots/')
      end
    end
  end
  
end
