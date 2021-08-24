
#CC=clang go build -o bidder_module.dylib -buildmode=c-shared bidder_module.go
#g++ main.cpp bidder_module.dylib -o main && ./main

#CC=clang go build fff.go
#CC=clang go build -o ff.dylib -buildmode=c-shared ff.go

clang -c -x objective-c ff.m
CC=clang go build -o fff.dylib -buildmode=c-shared fff.go


