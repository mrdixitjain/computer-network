set ns [new Simulator]

$ns color 1 blue

set nf [open out.nam w]
$ns namtrace-all $nf

proc finish {} {
    global ns nf
    $ns flush-trace
    
    close $nf
    
    exec nam out.nam &
    exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 2Mb 10ms DropTail
$ns duplex-link $n2 $n4 2Mb 10ms DropTail

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient left-down
$ns duplex-link-op $n2 $n3 orient left-down
$ns duplex-link-op $n2 $n4 orient right-down

$ns queue-limit $n2 $n3 10

$ns duplex-link-op $n2 $n3 queuePos 0.5

set tcp [new Agent/TCP]
$ns attach-agent $n1 $tcp

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $tcp
$cbr set type_ CBR 
$cbr set packet_size_ 1000
$cbr set rate_ 1mb
$cbr set random_ false

set sink [new Agent/TCPSink] 
$ns attach-agent $n3 $sink 
$ns connect $tcp $sink 
$tcp set fid_ 1

$ns at 0.5 "$cbr start"
$ns at 4.0 "$cbr stop"

$ns at 5.0 "finish"

# Print CBR packet size and interval 
puts "CBR packet size = [$cbr set packet_size_]"
puts "CBR interval = [$cbr set interval_]"

# Run the simulation 
$ns run 

