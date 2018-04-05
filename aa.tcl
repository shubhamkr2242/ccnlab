







































































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


c code:

1)CRC

#include <stdio.h>
 #include <conio.h>
 #include <string.h>
int main()
 {
 int i,j,keylen,msglen;
 char input[100], key[30],temp[30],quot[100],rem[30],key1[30],input2[100];

 printf("Enter Dataword: ");
 gets(input);
 printf("Enter agreed Divisor: ");
 gets(key);
 keylen=strlen(key);
 msglen=strlen(input);
 strcpy(key1,key);
 for(i=0;i<keylen-1;i++)
 {
 input[msglen+i]='0';
 }

 for(i=0;i<keylen;i++)
 temp[i]=input[i];
 for(i=0;i<msglen;i++)
 {
 quot[i]=temp[0];
 if(quot[i]=='0')
 for(j=0;j<keylen;j++)
 key[j]='0';
 else
 for(j=0;j<keylen;j++)
 key[j]=key1[j];
 for(j=keylen-1;j>0;j--)
 {
 if(temp[j]==key[j])
 rem[j-1]='0';
 else
 rem[j-1]='1';
 }
 rem[keylen-1]=input[i+keylen];
 strcpy(temp,rem);
 }
 strcpy(rem,temp);
 printf("\n Our Quotient is ");
 for(i=0;i<msglen;i++)
 printf("%c",quot[i]);
 printf("\n Our Remainder is ");
 for(i=0;i<keylen-1;i++)
 printf("%c",rem[i]);
 printf("\n Our Final data is: ");
 for(i=0;i<msglen;i++)
 printf("%c",input[i]);
 for(i=0;i<keylen-1;i++)
 printf("%c",rem[i]);
  printf("\n Enter received CodeWord: ");
 gets(input2);
for(i=0;i<keylen;i++)
 temp[i]=input2[i];
 for(i=0;i<msglen;i++)
 {
 quot[i]=temp[0];
 if(quot[i]=='0')
 for(j=0;j<keylen;j++)
 key[j]='0';
 else
 for(j=0;j<keylen;j++)
 key[j]=key1[j];
 for(j=keylen-1;j>0;j--)
 {
 if(temp[j]==key[j])
 rem[j-1]='0';
 else
 rem[j-1]='1';
 }
 rem[keylen-1]=input2[i+keylen];
 strcpy(temp,rem);
 }
 printf("Our syndrome is\n");
  for(i=0;i<keylen-1;i++)
 printf("%c",rem[i]); 
  getch();
 }

2)Bit stuffing and de-stuffing

#include<stdio.h>
#include<stdlib.h>
#define MAXSIZE 100

int main()
{
  char *p,*q;
  char temp;
  char in[MAXSIZE];
  char stuff[MAXSIZE];
  char destuff[MAXSIZE];

  int count=0;

  printf("enter the input character string (0‘s & 1‘s only):\n");
  scanf("%s",in);
  p=in;
  q=stuff;

  while(*p!='\0')
  {
    if(*p=='0')
    {
      *q=*p;
      q++;
      p++;
    }
    else
    {
      while(*p=='1' && count!=5)
      {
        count++;
        *q=*p;
        q++;
        p++;
      }

      if(count==5)
      {
        *q='0';
        q++;
      }
      count=0;
    }
  }
  *q='\0';
  printf("\nthe stuffed character string is");
  printf("\n%s",stuff);

  p=stuff;
  q=destuff;
  while(*p!='\0')
  {
    if(*p=='0')
    {
      *q=*p;
      q++;
      p++;
    }
    else
    {
      while(*p=='1' && count!=5)
      {
        count++;
        *q=*p;
        q++;
        p++;
      }
      if(count==5)
      {
        p++;
      }
      count=0;
    }
  }
  *q='\0';
  printf("\nthe destuffed character string is");
  printf("\n%s\n",destuff);
  return 0;
}

3)Byte stuffing

#include<stdio.h>
#include<conio.h>
#include<string.h>
#include<process.h>

char a[20],b[50],c[50],ch;
int i=0,n;
void sender();
void receiver();
void main()
{
clrscr();
sender();
receiver();
getch();
}
void sender()
{
int j=0,pos;
printf("\n\n Sender side \n\n");
printf("Enter string : ");
scanf("%s",&a);
n=strlen(a);
printf("\n Enter position : ");
scanf("%d",&pos);

label: if(pos>n)
{
printf("\n Invalid position, Enter again : ");
scanf("%d",&pos);
goto label;
}
printf("\n Enter the character : ");
ch=getche();
b[0]='d';
b[1]='l';
b[2]='e';
b[3]='s';
b[4]='t';
b[5]='x';
j=6;
while(i<n)
{
if(i==pos-1)
{
b[j]='d';
b[j+1]='l';
b[j+2]='e';
b[j+3]=ch;
b[j+4]='d';
b[j+5]='l';
b[j+6]='e';
j=j+7;
}
if(a[i]=='d' && a[i+1]=='l' && a[i+2]=='e')
{
b[j]='d';
b[j+1]='l';
b[j+2]='e';
j=j+3;
}
b[j]=a[i];
i++;
j++;
}
b[j]='d';
b[j+1]='l';
b[j+2]='e';
b[j+3]='e';
b[j+4]='t';
b[j+5]='x';
b[j+6]='\0';
printf("\nframe after stuffing : %s" ,b);
}
void receiver()
{
int j=6;
printf("\n\n\n\n Receiver side\n\n");
printf("\nThe data came from sender side is : %s",b);
n=strlen(b);
while(j<n-6)
{
if(b[j]=='d' && b[j+1]=='l' && b[j+2]=='e')
{
if(b[j+3]=='d' && b[j+4]=='l' && b[j+5]=='e')
{
c[i]=b[j+3];
c[i+1]=b[j+4];
c[i+2]=b[j+5];
i = i+3;
j = j+6;
}
else if(b[j+4]=='d' && b[j+5]=='l' && b[j+6]=='e')
{
j = j+7;
}
}
else
{
c[i]=b[j];
i++;
j++;
}
}
printf("\n\nOriginal data : %s",c);
}

4)djiktras 

#include<stdio.h> 
#include<conio.h> 
#define INFINITY 999 
void dijikstra(int G[10][10], int n, int root); 
void main(){ 
int G[10][10], i, j, n, u; 
printf("\nEnter the no. of nodes: "); 
scanf("%d", &n); 
printf("\nEnter the adjacency matrix:\n"); 
for(i=0;i < n;i++) 
for(j=0;j < n;j++) 
scanf("%d", &G[i][j]); 
printf("\nEnter Root Node: "); 
scanf("%d", &u); 
dijikstra(G,n,u); 
getch(); 
} 
void dijikstra(int G[10][10], int n, int root) 
{ 
int cost[10][10], D[10], pred; 
int visited[10], count, mindistance, nextnode, i,j; 
for(i=0;i < n;i++) 
for(j=0;j < n;j++) 
if(G[i][j]==0) 
cost[i][j]=INFINITY; 
else 
cost[i][j]=G[i][j]; 
for(i=0;i< n;i++) 
{ 
D[i]=cost[root][i]; 
pred=root; 
visited[i]=0; 
} 
D[root]=0; 
visited[root]=1; 
count=1; 
while(count < n-1){ 
mindistance=INFINITY; 
for(i=0;i < n;i++) 
if(D[i] < mindistance&&!visited[i]) 
{ 
mindistance=D[i]; 
nextnode=i; 
} 
visited[nextnode]=1;
for(i=0;i < n;i++) 
if(!visited[i]) 
if(mindistance+cost[nextnode][i] < D[i]) 
{ 
D[i]=mindistance+cost[nextnode][i]; 
pred=nextnode; 
} 
count++; 
} 
for(i=0;i < n;i++) 
if(i!=root) 
{ 
printf("\nDistance of %d = %d", i, D[i]); 
} 
} 


