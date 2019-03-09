nim c --app:lib --out:nimformat.so --compileOnly:on ./src/nimformat.nim
cp /usr/lib/nim/nimbase.h ./
cp ~/.cache/nim/nimformat_d/*.c ./
cp ~/.cache/nim/nimformat_d/*.h ./
python3 setup.py sdist --formats=zip