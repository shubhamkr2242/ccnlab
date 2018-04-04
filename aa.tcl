













































1)//point to point wired network suing Ns2

#Create an instance of Simulator Class
set ns [new Simulator]
#create a Trace File
set tf [open sample2.tr w]
$ns trace-all $tf
#Create a NAM file
set nf [open sample2.nam w]
$ns namtrace-all $nf
#create nodes and duplex links
set n0 [$ns node]
set n1 [$ns node]
$ns duplex-link $n0  $n1 1Mb 10ms DropTail
#Create Trasport Agents
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0
#Generate Application Traffic
#Constant Bit Rate Application (CBR)
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
#Virtually connect these 2 agents
$ns connect $udp0 $null0
#Finish Procedure
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam sample2.nam &
exit 0
}
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run

2)//point to point wired network suing Ns2 //interval to 2ms 

#Create an instance of Simulator Class
set ns [new Simulator]
#create a Trace File
set tf [open sample2.tr w]
$ns trace-all $tf
#Create a NAM file
set nf [open sample2.nam w]
$ns namtrace-all $nf
#create nodes and duplex links
set n0 [$ns node]
set n1 [$ns node]
$ns duplex-link $n0  $n1 1Mb 10ms DropTail
#Create Trasport Agents
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set null0 [new Agent/Null]
$ns attach-agent $n1 $null0
#Generate Application Traffic
#Constant Bit Rate Application (CBR)
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.002
$cbr0 attach-agent $udp0
#Virtually connect these 2 agents
$ns connect $udp0 $null0
#Finish Procedure
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam sample2.nam &
exit 0
}
$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run

3)//Simulation of Queuing Models in Star Topology

//1.Using Droptail:

#Create an instance of simulator class
set ns [new Simulator]

set tf [open star.tr w]
$ns trace-all $tf
set nf [open star.nam w]
$ns namtrace-all $nf

set num 4

$ns color 1 Blue
$ns color 2 Red

for {set i 0} {$i <$num} {incr i} {
set n($i) [$ns node]
}

$ns duplex-link $n(0) $n(2) 1Mb 10ms  DropTail
$ns duplex-link $n(1) $n(2) 1Mb 10ms  DropTail
$ns duplex-link $n(2) $n(3) 1Mb 10ms  DropTail

#Duplex link orientation
$ns duplex-link-op $n(0) $n(2) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns duplex-link-op $n(2) $n(3) orient right
 
$ns duplex-link-op $n(2) $n(3) queuePos 0.5

set udp0 [new Agent/UDP]
$udp0 set class_ 1
$ns attach-agent $n(0) $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

$ns connect $udp0 $null0

set udp1 [new Agent/UDP]
$udp1 set class_ 2
$ns attach-agent $n(1) $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

$ns connect $udp1 $null0

proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam star.nam &
exit 0
}

$ns at 0.5 "$cbr0 start"
$ns at 1.0 "$cbr1 start"
$ns at 4.5 "$cbr0 stop"
$ns at 4.5 "$cbr1 stop"
$ns at 5.0 "finish"
$ns run

4)//Simulation of Queuing Models in Star Topology
//1.Using SFQ:

#Create an instance of simulator class
set ns [new Simulator]

set tf [open star.tr w]
$ns trace-all $tf
set nf [open star.nam w]
$ns namtrace-all $nf

set num 4

$ns color 1 Blue
$ns color 2 Red

for {set i 0} {$i <$num} {incr i} {
set n($i) [$ns node]
}

$ns duplex-link $n(0) $n(2) 1Mb 10ms  DropTail
$ns duplex-link $n(1) $n(2) 1Mb 10ms  DropTail
#SFQ- Stochastic Fair Queuing
$ns duplex-link $n(2) $n(3) 1Mb 10ms SFQ

#Duplex link orientation
$ns duplex-link-op $n(0) $n(2) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns duplex-link-op $n(2) $n(3) orient right
 
$ns duplex-link-op $n(2) $n(3) queuePos 0.5

set udp0 [new Agent/UDP]
$udp0 set class_ 1
$ns attach-agent $n(0) $udp0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0

$ns connect $udp0 $null0

set udp1 [new Agent/UDP]
$udp1 set class_ 2
$ns attach-agent $n(1) $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1

$ns connect $udp1 $null0

proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam star.nam &
exit 0
}

$ns at 0.5 "$cbr0 start"
$ns at 1.0 "$cbr1 start"
$ns at 4.5 "$cbr0 stop"
$ns at 4.5 "$cbr1 stop"
$ns at 5.0 "finish"
$ns run

5)//Simulation of ring topology and analysis of static/dynamic routing in case of link failures/node failures
//1.Static routing:

set ns [new Simulator]
set tf [open ring.tr w]
$ns trace-all $tf
set nf [open ring.nam w]
$ns namtrace-all $nf
set num 7
for {set i 0} {$i < $num} {incr i} {
set n($i) [$ns node]
}
#Create duplex-link
for {set i 0} {$i < $num} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%$num]) 1Mb 10ms DropTail
}
#Create Transport Agent
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0
#Create Application Traffic
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0
$ns connect $udp0 $null0
proc finish {} {
global ns nf tf
$ns flush-trace
close $tf
close $nf
exec nam ring.nam &
exit 0
}
#Schedule Traffic
$ns at 0.5 "$cbr0 start"
$ns rtmodel-at 1.0 down $n(1) $n(2)
$ns rtmodel-at 2.0 up $n(1) $n(2)
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run

5)//Simulation of ring topology and analysis of static/dynamic routing in case of link failures/node failures
//2.Dynamic Routing: 

set ns [new Simulator]
#Enalble Dynamic Routing in NS2
#DV -Distance Vector Routing Protocol
$ns rtproto DV
set tf [open ring.tr w]
$ns trace-all $tf
set nf [open ring.nam w]
$ns namtrace-all $nf
set num 7
for {set i 0} {$i < $num} {incr i} {
set n($i) [$ns node]
}
#Create duplex-link
for {set i 0} {$i < $num} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%$num]) 1Mb 10ms DropTail
}
#Create Transport Agent
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0
#Create Application Traffic
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0
$ns connect $udp0 $null0
proc finish {} {
global ns nf tf
$ns flush-trace
close $tf
close $nf
exec nam ring.nam &
exit 0
}
#Schedule Traffic
$ns at 0.5 "$cbr0 start"
$ns rtmodel-at 1.0 down $n(1) $n(2)
$ns rtmodel-at 2.0 up $n(1) $n(2)
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"
$ns run

6)//Simulation of ring topology and analysis of static/dynamic routing in case of link failures/node failures
//In case when the weights are changed: 

set ns [new Simulator]
set tf [open ring.tr w]
$ns trace-all $tf
set nf [open ring.nam w]
$ns namtrace-all $nf
set num 7
for {set i 0} {$i < $num} {incr i} {
set n($i) [$ns node]
}
#Create duplex-link
for {set i 0} {$i < $num} {incr i} {
$ns duplex-link $n($i) $n([expr ($i+1)%$num]) 1Mb 10ms DropTail
}
#Create Transport Agent
set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0
#Create Application Traffic
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 attach-agent $udp0
set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0
$ns connect $udp0 $null0
proc finish {} {
global ns nf tf
$ns flush-trace
close $tf
close $nf
exec nam ring.nam &
exit 0
}
#Schedule Traffic
$ns at 0.5 "$cbr0 start"
$ns rtmodel-at 1.0 down $n(1) $n(2)
$ns rtmodel-at 2.0 up $n(1) $n(2)
#Assign different weight to edges
$ns cost $n(2) 
$n(3) 5
$ns at 4.5 "$cbr0 stop"
$ns at 5.0 "finish"

7)//Simulation of Ethernet (IEEE 802.3) LAN Bus topology 

set ns [new Simulator] 
set tf [open 8023.tr w] 
$ns trace-all $tf 
set nf [open 8023.nam w] 
$ns namtrace-all $nf 
#Layer Wise Simulation Parameters 
#Bandwidth 
set opt(bw) 1Mb 
#propagation delay 
set opt(delay) 10ms 
#Data link layer- Link Layer Class 
set opt(ll) LL 
#Mac Class is 802_3 -CSMA/CD 
set opt(mac) Mac/802_3 
#Channel class for multipoint link 
set opt(chan) Channel
#Network Interface Queue 
set opt(ifq) Queue/DropTail 
#Simulation Finish Time 
set opt(fin) 20.0 
if {$argc !=2} { 
puts "usage : ns csmacd.tcl <number of nodes> <No of Traffic sources>" 
puts "Example ns csmacd.tcl 10 2" 
exit 
} 
set opt(nn) [lindex $argv 0] 
set opt(num) [lindex $argv 1] 
for {set i 0} {$i < $opt(nn)} { incr i} { 
set node($i) [$ns node] 
#Add all the node objects to a list 
lappend nodeList $node($i) 
} 
$ns make-lan -trace on $nodeList
 $opt(bw) $opt(delay) $opt(ll) $opt(ifq) $opt(mac) $opt(chan) 
#Please attach a external node to Bus network and orient right 
set nodex [$ns node] 
$ns duplex-link $nodex $node(0) 10Mb 10ms DropTail 
$ns duplex-link-op $nodex $node(0) orient right 
set null(0) [new Agent/Null] 
$ns attach-agent $node(0) $null(0) 
for {set i 1} {$i <= $opt(num)} {incr i} { 
#Create UDP Agents 
set udp($i) [new Agent/UDP] 
$ns attach-agent $node($i) $udp($i) 
set cbr($i) [new Application/Traffic/CBR] 
$cbr($i) set packetSize_ 1000 
$cbr($i) set rate_ 100Kb 
#Alternate to interval parameter is rate parameter 
$cbr($i) attach-agent $udp($i) 
$ns connect $udp($i) $null(0) 
$ns at 0.5 "$cbr($i) start" 
$ns at $opt(fin) "$cbr($i) stop" 
#Attach to Traffic Sources 
} 
$ns at $opt(fin) "finish" 
proc finish {} { 
global ns nf tf 
$ns flush-trace 
close $tf 
close $nf
exec nam 8023.nam & 
exit 0 
} 
$ns run 

8)//TCP Congestion Control Mechanism

#Create an object of Simulator Class 
set ns [new Simulator]
#Create NAM and Trace File 
set nf [open congestion.nam w]
$ns namtrace-all $nf
set tf [open congestion.tr w]
$ns trace-all $tf
$ns color 1 Blue
$ns color 2 Red
#Create Nodes 
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
#Create Links 
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 1.2Mb 20ms DropTail
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orientright
$ns duplex-link-op $n2 $n3 queuePos 0.5
#Create Transport Agent 
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
$tcp set class_ 1
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
set udp [new Agent/UDP]
$udpset class_ 2
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null
#Create Application Traffic 
set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 1000
$cbr set rate_ 1Mb
$cbr attach-agent $udp
setftp [new Application/FTP]
$ftp attach-agent $tcp
#Default setting in ns2 - sstresh_ 20 
set outfile [open congestion.txt w]
proc plotWindow {tcpSource outfile} {
global ns
set now [$ns now]
set cwnd [$tcpSource set cwnd_]
puts $outfile "$now $cwnd"
$ns at[expr $now+0.1] "plotWindow $tcpSource $outfile"
}
$ns at 1.0 "plotWindow $tcp $outfile"
#Schedule Traffic 
$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 20.0 "$ftp stop"
$ns at 20.5 "$cbr stop"
$ns at 20.6 "finish"
proc finish {} {
global ns nf tf
$ns flush-trace
close $nf
close $tf
exec nam congestion.nam &
exit 0
}
#Finish and Run 
$ns run
