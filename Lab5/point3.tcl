
set ns [new Simulator] 

$ns color 1 Blue

set nf [open out.nam w] 
set nr [open out1.tr w]
$ns trace-all $nr
$ns namtrace-all $nf 


proc finish {} { 
	global ns nf 
	$ns flush-trace
	close $nf
	
	
	set plo [open plotta.out w]
	puts $plo "set x label \"time(seconds)\""	
	puts $plo "set y label \"packets\""
	puts $plo "set output \ Cwnd.eps\""
	puts $plo "set terminal postscript eps"
	puts $plo "plot \"nf\" with lines" 
	close $plo
	close $nf
	exec gnuplot plotta.out

	exec nam out.nam & 
	exit 0
} 


set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node]


$ns duplex-link $n1 $n2 2Mb 10ms DropTail 
$ns duplex-link $n2 $n3 512Kb 10ms DropTail 


$ns queue-limit $n2 $n3 10

 
$ns duplex-link-op $n1 $n2 orient up
$ns duplex-link-op $n2 $n3 orient right

#$ns duplex-link-op $n3 $n4 queuePos 0.5

set tcp [new Agent/TCP]
$tcp set class_ 1
$ns attach-agent $n1 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $tcp $sink

set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.01
$cbr attach-agent $tcp


$ns at 0.1 "$cbr start"
$ns at 4.0 "$cbr stop"

$ns at 4.5 "finish"


$ns run 
