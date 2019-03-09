rm ./*.c
rm ./*.h
nim c --app:lib --out:nimformat.so --compileOnly -d:release ./src/nimformat.nim
cp /usr/lib/nim/nimbase.h ./
cp ~/.cache/nim/nimformat_r/*.c ./
python3 setup.py sdist --formats=zip