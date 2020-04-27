set ns [new Simulator] 

$ns color 1 purple
$ns color 2 brown 

set nf [open q2.nam w]
set nr [open q2.tr w] 
$ns trace-all $nr
$ns namtrace-all $nf 


proc finish {} { 
	global ns nf nr
	$ns flush-trace 
	close $nf  
	close $nr
	exec nam q2.nam & 
	exit 0
} 

set n0 [$ns node] 
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail 
$ns duplex-link $n1 $n2 2Mb 10ms DropTail 
$ns duplex-link $n2 $n3 512Kb 20ms DropTail 

$ns queue-limit $n2 $n3 10


set tcp [new Agent/TCP] 
$tcp set class_ 2
$ns attach-agent $n0 $tcp 

set sink [new Agent/TCPSink] 
$ns attach-agent $n3 $sink 
$ns connect $tcp $sink 
$tcp set fid_ 1

set ftp [new Application/FTP] 
$ftp attach-agent $tcp 
$ftp set type_ FTP 


set udp [new Agent/UDP] 
$ns attach-agent $n1 $udp 
set null [new Agent/Null] 

$ns attach-agent $n3 $null 
$ns connect $udp $null 
$udp set fid_ 2

set cbr [new Application/Traffic/CBR] 
$cbr attach-agent $udp 
$cbr set type_ CBR 
$cbr set packet_size_ 1000
$cbr set rate_ 1mb


$ns at 0.1 "$cbr start"
$ns at 0.5 "$ftp start"
$ns at 4.0 "$ftp stop"
$ns at 4.5 "$cbr stop"

$ns at 5.0 "finish"

$ns run 


