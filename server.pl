#!/usr/bin/perl -w
use strict;

package Server;

#initialize network layer
sub initNetwork () {
    use Socket;
    use IO::Select;

    $| = 1;
    my($proto, $port , $sock);

    $proto = getprotobyname('tcp');

    #create a socket handle (descriptor)
    socket($sock, AF_INET, SOCK_STREAM, $proto)
        or die "could not create socket : $!";

    #bind to local port passed as arg
    $port = "6667";
    bind($sock , sockaddr_in($port, INADDR_ANY))
        or  die "bind failed : $!";

    listen($sock , 10); # open a socket for
    print "Server is now listening on port ".$port."...\n";

    #start accepting incoming connections
    connectionsLoop($sock);

    #close the socket
    close($sock);
    exit(0);
}

sub connectionsLoop ($sock) {
    my($s , @ready , $so , $addrinfo , $client , $inp);
    #accept incoming connections and talk to clients
    $s = IO::Select->new();

    $s->add($sock);

    while(1)
    {
        @ready = $s->can_read(0);

        foreach $so(@ready)
        {
            #new connection read
            if($so == $sock)
            {
                my($client);
                $addrinfo = accept($client , $sock);

                my($port, $iaddr) = sockaddr_in($addrinfo);
                my $name = gethostbyaddr($iaddr, AF_INET);

                print "Connection accepted from $name : $port \n";

                #send some message to the client
                #send($client , "Hello client how are you\n" , 0);

                $s->add($client);
            }

            # existing client read
            else
            {
                chop($inp = <$so>);
                chop($inp);
                print "Received -- $inp \n";

                #send reply back to client
                #send($so , "OK : $inp\n" , 0);
            }
        }
    }
}

initNetwork();
