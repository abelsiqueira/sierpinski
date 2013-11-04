#Makefile

#OPTIONS += -Dsilent
#OPTIONS += -Donline

compile:
	openfl build project.xml flash --no-traces $(OPTIONS)
	cp bin/flash/bin/Main.swf sierpinski.swf

info:
	openfl build project.xml flash --no-traces -Dinfo $(OPTIONS)
	cp bin/flash/bin/Main.swf sierpinski.swf

debug:
	openfl build project.xml flash -debug $(OPTIONS)
	cp bin/flash/bin/Main.swf sierpinski.swf

cpp:
	openfl test project.xml cpp -debug 

run:
	chromium sierpinski.html &

linux-debug:
	openfl build project.xml -debug linux $(OPTIONS)
	./bin/linux64/cpp/bin/Main
