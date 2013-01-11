File.open('input.txt', 'rb') do |i|
  File.open('output.txt', 'wb') do |o|
    buf = ""
    bufsiz = (i.stat.blksize or 16384)
    while i.read(bufsiz, buf) do o.write(buf) end
  end
end