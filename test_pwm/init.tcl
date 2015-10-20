set nfacs [ gtkwave::getNumFacs ]
set dumpname [ gtkwave::getDumpFileName ]
set dmt [ gtkwave::getDumpType ]

puts "number of signals in dumpfile '$dumpname' of type $dmt: $nfacs"

for {set i 0} {$i < $nfacs } {incr i} {
	set facname [ gtkwave::getFacName $i ]
	set num_added [ gtkwave::addSignalsFromList $facname ]
	#gtkwave::/Edit/Data_Format/Analog/Step
	#gtkwave::/Edit/Insert_Analog_Height_Extension
	#gtkwave::/Edit/Insert_Analog_Height_Extension
}
gtkwave::/Edit/UnHighlight_All
gtkwave::/Time/Zoom/Zoom_Full
