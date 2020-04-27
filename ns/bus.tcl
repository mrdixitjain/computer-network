set ns [new Simulator]
set nf [open mi.nam w]
$ns namtrace-all $nf

set newr [open R.tr w]

set tf [open mi.tr w]
$ns trace-all $tf

proc finish { } {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam mi.nam &
exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
$n3 label "destination"

$ns duplex-link $n0 $n2 10Mb 1ms DropTail
$ns duplex-link $n1 $n2 1Mb 100ms DropTail
$ns duplex-link $n2 $n3 1Mb 100ms DropTail


set tcp0 [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp0

set ftp0 [new Application/FTP]
$ftp0 set packet_Size_ 500
$ftp0 set interval_ 0.005
$ftp0 attach-agent $tcp0

set tcp1 [new Agent/TCP/Newreno]
$ns attach-agent $n1 $tcp1

set ftp1 [new Application/FTP]
$ftp1 set packet_Size_ 1000
$ftp1 set interval_ 0.05
$ftp1 attach-agent $tcp1

set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0

set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1

$ns connect $tcp0 $sink0
$ns connect $tcp1 $sink1

$ns at 0.1 "$ftp0 start"
$ns at 0.1 "$ftp1 start"
# ####################################################################
# plotWindow(tcpSource,file): write CWND from $tcpSource
#                       to output file $file every 0.1 sec
  proc plotWindow {tcpSource file} {
     global ns

     set time 0.1
     set now [$ns now]
     set cwnd [$tcpSource set cwnd_]
     set wnd [$tcpSource set window_]
     puts $file "$now $cwnd"
     $ns at [expr $now+$time] "plotWindow $tcpSource $file"
  }
# ####################################################################
# Start plotWindow
 $ns at 0.1 "plotWindow $tcp0 $newr"
