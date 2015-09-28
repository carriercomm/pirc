#!/usr/bin/env perl
use strict;

package Server;

sub listen () {
use Socket;

    my $sock;
    my $port = 6667; #irc port

    socket($sock, AF_INET, SOCK_STREAM, getprotobyname('tcp')) or die $!;
    
    #bind soket descriptor to local port
    bind($sock , sockaddr_in($port, INADDR_ANY))
        or  die "bind failed : $!";
    #accept incoming connections
    while(1)
    {
        my($client);
        my $addrinfo = accept($client , $sock);
     
        my($port, $iaddr) = sockaddr_in($addrinfo);
        my $name = gethostbyaddr($iaddr, AF_INET);
     
        print "Connection accepted from $name : $port \n";
     
        #send some message to the client
        print $client "Hello client how are you\n";
    }
 
    close($sock);
}

listen();
