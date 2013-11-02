#Makefile

#SILENT=-Dsilent

compile:
	openfl build project.xml flash --no-traces $(SILENT)
	cp bin/flash/bin/Main.swf sierpinski.swf

info:
	openfl build project.xml flash --no-traces -Dinfo $(SILENT)
	cp bin/flash/bin/Main.swf sierpinski.swf

debug:
	openfl build project.xml flash -debug $(SILENT)
	cp bin/flash/bin/Main.swf sierpinski.swf

cpp:
	openfl test project.xml cpp -debug 

run:
	chromium sierpinski.html &

linux-debug:
	openfl build project.xml -debug linux $(SILENT)
	./bin/linux64/cpp/bin/Main
